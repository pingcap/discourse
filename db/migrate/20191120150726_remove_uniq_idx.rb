class RemoveUniqIdx < ActiveRecord::Migration[5.2]
  def change
    remove_index :reviewables, [:type,:target_id]
    add_index :reviewables, [:type, :target_id]
  end
end
