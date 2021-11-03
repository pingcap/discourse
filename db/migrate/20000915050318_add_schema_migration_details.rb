# frozen_string_literal: true

class AddSchemaMigrationDetails < ActiveRecord::Migration[4.2]
  def up
    # schema_migrations table is way too thin, does not give info about
    # duration of migration or the date it happened, this migration together with the
    # monkey patch adds a lot of information to the migration table

    execute("INSERT INTO schema_migration_details(version, created_at)
             SELECT version, current_timestamp
             FROM schema_migrations
             ORDER BY version
            ")
  end

  def down
  end
end
