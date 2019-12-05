# frozen_string_literal: true

class BadgePostsViewManager
  VIEW_NAME = "badge_posts".freeze

  def self.create!
    sql = <<~SQL
    CREATE OR REPLACE VIEW #{VIEW_NAME} AS
    SELECT p.*
    FROM posts p
    JOIN topics t ON t.id = p.topic_id
    JOIN categories c ON c.id = t.category_id
    WHERE c.allow_badges AND
          p.deleted_at IS NULL AND
          t.deleted_at IS NULL AND
          NOT c.read_restricted AND
          t.visible AND
          p.post_type IN (1,2,3)
    SQL

    DB.exec(sql)
  end

  def self.drop!
    DB.exec("DROP VIEW IF EXISTS #{VIEW_NAME}")
  end
end
