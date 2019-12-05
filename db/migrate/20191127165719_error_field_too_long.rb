class ErrorFieldTooLong < ActiveRecord::Migration[5.2]
  def change
    change_column :theme_fields, :error, :text
  end
end
