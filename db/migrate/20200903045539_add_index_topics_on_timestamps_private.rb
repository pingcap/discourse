# frozen_string_literal: true

class AddIndexTopicsOnTimestampsPrivate < ActiveRecord::Migration[6.0]

  def up
    execute <<~SQL
    CREATE INDEX IF NOT EXISTS
    index_topics_on_timestamps_private
    ON topics (bumped_at, created_at, updated_at)
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
