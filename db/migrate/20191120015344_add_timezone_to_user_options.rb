# frozen_string_literal: true

class AddTimezoneToUserOptions < ActiveRecord::Migration[6.0]
  def up
    add_column :user_options, :timezone, :string
    execute(
      <<-SQL
        UPDATE user_options inner join user_custom_fields as ucf
        SET timezone = ucf.value
        WHERE ucf.user_id = user_options.user_id AND ucf.name = 'timezone'
      SQL
    )
  end

  def down
    remove_column :user_options, :timezone
  end
end
