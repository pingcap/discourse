class RemoveIdx5 < ActiveRecord::Migration[5.2]
  def change
    remove_index :post_custom_fields, name: :post_custom_field_broken_images_idx
  end
end
