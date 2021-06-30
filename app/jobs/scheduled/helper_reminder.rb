# frozen_string_literal: true

module Jobs

  class HelperReminder < Jobs::Scheduled
    daily at: 10.hours

    def execute(args)
      Topic.where(archetype: :regular).where(created_at: 2.days.ago..Time.now).where("posts_count > 1").each do |topic|
        next if topic.custom_fields["accepted_answer_post_id"].present?
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

  end

end
