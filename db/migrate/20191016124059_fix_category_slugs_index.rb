# frozen_string_literal: true

class FixCategorySlugsIndex < ActiveRecord::Migration[6.0]
  def change
    return
    # TODO FIX
    add_index(
      :categories,
      'COALESCE(parent_category_id, -1), slug',
      name: 'unique_index_categories_on_slug',
      where: "slug != ''",
      unique: true
    )
  end
end
