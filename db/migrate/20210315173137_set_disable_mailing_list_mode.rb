# frozen_string_literal: true

class SetDisableMailingListMode < ActiveRecord::Migration[6.0]
  def up
    result = query_value "SELECT COUNT(*) FROM user_options WHERE mailing_list_mode"
    if  result && result > 0
      execute <<~SQL
        INSERT IGNORE INTO site_settings(name, data_type, value, created_at, updated_at)
        VALUES('disable_mailing_list_mode', 5, 'f', NOW(), NOW())
      SQL
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
