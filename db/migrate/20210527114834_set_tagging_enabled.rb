# frozen_string_literal: true

class SetTaggingEnabled < ActiveRecord::Migration[6.1]
  def up
    result = query_value <<~SQL
      SELECT created_at
      FROM schema_migration_details
      ORDER BY created_at
      LIMIT 1
    SQL

    # keep tagging disabled for existing sites
    if result && result.to_datetime < 1.hour.ago
      execute <<~SQL
        INSERT IGNORE INTO site_settings(name, data_type, value, created_at, updated_at)
        VALUES('tagging_enabled', 5, 'f', NOW(), NOW())
      SQL
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
