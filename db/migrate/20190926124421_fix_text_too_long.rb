class FixTextTooLong < ActiveRecord::Migration[5.2]
  def change
    change_column :stylesheet_cache, :content, :longtext
  end
end
