# frozen_string_literal: true

class TopicFeaturedUsers
  attr_reader :topic

  def initialize(topic)
    @topic = topic
  end

  def self.count
    4
  end

  # Chooses which topic users to feature
  def choose(args = {})
    self.class.ensure_consistency!(topic.id.to_i)
    update_participant_count
  end

  def user_ids
    [topic.featured_user1_id,
     topic.featured_user2_id,
     topic.featured_user3_id,
     topic.featured_user4_id].uniq.compact
  end

  def self.ensure_consistency!(topic_id = nil)
    filter = "#{"AND t.id = #{topic_id.to_i}" if topic_id}"
    filter2 = "#{"AND tt.id = #{topic_id.to_i}" if topic_id}"

    init = <<~SQL
      SELECT
          t.id,
          p.user_id,
          MAX(p.created_at) last_post_date,
          count(*) as count
      FROM topics t
      JOIN posts p ON p.topic_id = t.id
      WHERE p.deleted_at IS NULL AND
          NOT p.hidden AND
          p.post_type in (#{Topic.visible_post_types.join(",")}) AND
          p.user_id <> t.user_id AND
          p.user_id <> t.last_post_user_id
          #{filter}
      GROUP BY t.id, p.user_id
    SQL

    cte = <<~SQL
      SELECT t1.id,
             t1.user_id,
             t1.last_post_date,
         @row_number := CASE WHEN @temp = t1.id THEN @row_number + 1 ELSE 1 END `rank`,
         @temp := t1.id tmp
      FROM 
      (SELECT * FROM (#{init}) t1 ORDER BY t1.id, t1.count DESC, t1.last_post_date DESC) t1,
      (SELECT @row_number := 1 `row_number`, @temp := '' temp) t2
    SQL

    cte2 = <<~SQL
      SELECT tt1.id,
             tt1.user_id,
         @row_number := CASE WHEN @temp = tt1.id THEN @row_number + 1 ELSE 1 END rank2,
         @temp := tt1.id tmp
      FROM 
      (SELECT * FROM (#{cte}) tt1 WHERE `rank` <= #{count} ORDER BY tt1.id, last_post_date ASC) tt1,
      (SELECT @row_number := 1 `row_number`, @temp := '' temp) tt2
    SQL

    sql = <<~SQL
      UPDATE topics tt
      LEFT JOIN (
        SELECT
            c.id,
            MAX(case when c.rank2 = 1 then c.user_id end) featured_user1,
            MAX(case when c.rank2 = 2 then c.user_id end) featured_user2,
            MAX(case when c.rank2 = 3 then c.user_id end) featured_user3,
            MAX(case when c.rank2 = 4 then c.user_id end) featured_user4
        FROM (#{cte2}) as c
        GROUP BY c.id
      ) x ON x.id = tt.id

      SET
        tt.featured_user1_id = x.featured_user1,
        tt.featured_user2_id = x.featured_user2,
        tt.featured_user3_id = x.featured_user3,
        tt.featured_user4_id = x.featured_user4
      WHERE
      (
        COALESCE(tt.featured_user1_id,-99) <> COALESCE(x.featured_user1,-99) OR
        COALESCE(tt.featured_user2_id,-99) <> COALESCE(x.featured_user2,-99) OR
        COALESCE(tt.featured_user3_id,-99) <> COALESCE(x.featured_user3,-99) OR
        COALESCE(tt.featured_user4_id,-99) <> COALESCE(x.featured_user4,-99)
      )
      #{filter2}
    SQL
    DB.exec(sql)
  end

  private

  def update_participant_count
    count = topic.posts.where('NOT hidden AND post_type in (?)', Topic.visible_post_types).count('distinct user_id')
    topic.update_columns(participant_count: count)
  end
end
