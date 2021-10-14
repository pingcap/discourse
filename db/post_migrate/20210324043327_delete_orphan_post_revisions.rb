# frozen_string_literal: true

class DeleteOrphanPostRevisions < ActiveRecord::Migration[6.0]
  def up
    return # TODO FIX
    sql = <<~SQL
        DELETE post_revisions FROM post_revisions
        INNER JOIN post_revisions pr ON pr.id = post_revisions.id
        LEFT JOIN posts ON posts.id = pr.post_id
        WHERE posts.id IS NULL
        AND post_revisions.id = pr.id
    SQL

    execute(sql)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
