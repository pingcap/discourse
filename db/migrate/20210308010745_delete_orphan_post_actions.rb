# frozen_string_literal: true

class DeleteOrphanPostActions < ActiveRecord::Migration[6.0]
  def up
    sql = <<~SQL
      DELETE post_actions FROM post_actions
      INNER JOIN post_actions pa ON post_actions.id = pa.id
      LEFT JOIN posts ON posts.id = pa.post_id
      WHERE posts.id IS NULL
      AND post_actions.id = pa.id
    SQL

    execute(sql)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
