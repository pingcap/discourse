# frozen_string_literal: true

module Jobs

  class HelperReminder < Jobs::Scheduled
    daily at: 2.hours

    def execute(args)
      Topic.where(archetype: :regular).where(created_at: 2.days.ago..Time.now).where("posts_count > 1").each do |topic|
        next if topic.custom_fields["accepted_answer_post_id"].present?
        next if not category_can_push?(topic)
        next if not post_can_push?(topic)
       
        current_reminder_count = topic.custom_fields["helper_reminder"].to_i
        if current_reminder_count == 0
          topic.custom_fields["helper_reminder"] = 1
          topic.save_custom_fields
          SystemMessage.create_from_system_user(
            topic.user,
            :helper_reminder,
            title: topic.title,
            url: Topic.url(topic.id, topic.slug)
          )
        end

        if current_reminder_count == 1
          topic.custom_fields["helper_reminder"] = 2
          topic.save_custom_fields
          SystemMessage.create_from_system_user(
            topic.user,
            :helper_reminder2,
            title: topic.title,
            url: Topic.url(topic.id, topic.slug)
          )
        end
      rescue
        next
      end
    end

    def category_can_push?(topic)
       @@category_ids ||= Category.where(name: ["部署&监控", "备份&数据迁移", "开发者&应用适配", "性能调优", "Real-Time HTAP", "互助交流区"]).pluck(:id)
       @@other_category_ids ||= Category.where(name: ['建议&反馈']).pluck(:id)
       return true if @@category_ids.include?(topic.category_id) || @@category_ids.include?(topic.category&.parent_category_id)
       return true if @@other_category_ids.include?(topic.category_id)
       return false
    end

    def post_can_push?(topic)
      topic.posts.map { |x| x.user_id}.reject { |x| x == topic.user_id || x == -1}.size >= 1 
    end

  end

end
