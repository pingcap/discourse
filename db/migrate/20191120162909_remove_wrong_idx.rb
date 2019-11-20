class RemoveWrongIdx < ActiveRecord::Migration[5.2]
  def change
    remove_index :post_custom_fields, name: :index_post_custom_fields_on_notice_type
    remove_index :post_custom_fields, name: :index_post_custom_fields_on_post_id
  end
end
