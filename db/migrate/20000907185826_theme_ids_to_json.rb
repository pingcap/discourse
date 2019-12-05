class ThemeIdsToJson < ActiveRecord::Migration[5.2]
  def change
    change_column :user_options, :theme_ids, :json
  end
end
