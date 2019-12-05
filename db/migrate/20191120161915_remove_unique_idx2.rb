class RemoveUniqueIdx2 < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_actions, name: 'idx_unique_rows'
    add_index :user_actions, ["action_type", "user_id", "target_topic_id", "target_post_id", "acting_user_id"], name: 'idx_unique_rows'
  end
end
