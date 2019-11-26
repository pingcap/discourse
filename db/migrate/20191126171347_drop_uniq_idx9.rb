class DropUniqIdx9 < ActiveRecord::Migration[5.2]
  def change
    remove_index :topic_timers, name: :idx_topic_id_public_type_deleted_at
  end
end
