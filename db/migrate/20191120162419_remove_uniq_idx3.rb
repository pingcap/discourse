class RemoveUniqIdx3 < ActiveRecord::Migration[5.2]
  def change
    remove_index :post_custom_fields, name: "index_post_custom_fields_on_notice_args"
    add_index :post_custom_fields, :post_id, name: 'index_post_custom_fields_on_notice_args'
  end
end
