# frozen_string_literal: true

class MoveApprovedQueuedPostsTopicAndPostData < ActiveRecord::Migration[6.1]
  def up
    DB.query_single <<~SQL
      UPDATE reviewables r
      SET topic_id = cast(payload->>'$.created_topic_id' AS SIGNED), target_id = cast(payload->>'$.created_post_id' AS SIGNED), target_type = 'Post'
      WHERE r.type = 'ReviewableQueuedPost' AND r.status = 1
      AND (r.payload->>'$.created_topic_id') IS NOT NULL
      AND (r.payload->>'$.created_post_id') IS NOT NULL
      AND topic_id IS NULL
      AND target_id IS NULL
    SQL
  end

  def down
  end
end
