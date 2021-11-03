# frozen_string_literal: true
class ClearApprovedUsersFromTheReviewQueue < ActiveRecord::Migration[6.0]
  def up
    DB.exec <<~SQL
      UPDATE reviewables r
      INNER JOIN users u
      SET status = #{Reviewable.statuses[:approved]}
      WHERE u.id = r.target_id AND u.approved = true
      AND r.type = 'ReviewableUser' AND r.status = #{Reviewable.statuses[:pending]}
    SQL

    reviewables = DB.query_single <<~SQL
      SELECT r.id 
        FROM reviewables r
             INNER JOIN users u
       WHERE u.id = r.target_id AND u.approved = true
             AND r.type = 'ReviewableUser' AND r.status = #{Reviewable.statuses[:pending]}
    SQL

    system_user_id = Discourse::SYSTEM_USER_ID
    scores = reviewables.map do |id|
      "(#{id}, 1, #{Reviewable.statuses[:approved]}, #{system_user_id}, NOW(), NOW())"
    end

    if scores.present?
      DB.exec <<~SQL
        INSERT INTO reviewable_histories (
          reviewable_id,
          reviewable_history_type,
          status,
          created_by_id,
          created_at,
          updated_at
        )
        VALUES #{scores.join(',') << ';'}
      SQL
    end
  end

  def down
  end
end
