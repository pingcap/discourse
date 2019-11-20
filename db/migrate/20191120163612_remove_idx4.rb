class RemoveIdx4 < ActiveRecord::Migration[5.2]
  def change
    remove_index :post_custom_fields, name: :index_post_id_where_missing_uploads_ignored
  end
end
