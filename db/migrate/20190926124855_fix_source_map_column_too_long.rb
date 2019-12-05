class FixSourceMapColumnTooLong < ActiveRecord::Migration[5.2]
  def change
    change_column :stylesheet_cache, :source_map, :longtext
  end
end
