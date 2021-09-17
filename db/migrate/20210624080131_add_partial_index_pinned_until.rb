# frozen_string_literal: true

class AddPartialIndexPinnedUntil < ActiveRecord::Migration[6.1]

  # Dropping to raw SQL here due to an ActiveRecord bug which prevents
  # using `algorithm: :concurrently` and `if_not_exists: true`
  # https://github.com/rails/rails/pull/41490

  def up
    execute <<~SQL
      CREATE INDEX IF NOT EXISTS "index_topics_on_pinned_until"
      ON "topics" ("pinned_until")
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX IF EXISTS "index_topics_on_pinned_until"
    SQL
  end
end
