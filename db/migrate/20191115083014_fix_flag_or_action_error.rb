class FixFlagOrActionError < ActiveRecord::Migration[5.2]
  def change
    remove_index :post_actions, name: :idx_unique_actions
    remove_index :post_actions, name: :idx_unique_flags
    add_index :post_actions, [:user_id, :post_action_type_id, :post_id, :targets_topic], name: :idx_unique_actions
    add_index :post_actions, [:user_id, :post_id, :targets_topic], name: :idx_unique_flags
  end
end