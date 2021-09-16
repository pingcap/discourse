# frozen_string_literal: true
class AddTimestampsToOptimizedImages < ActiveRecord::Migration[6.0]
  def change
    add_column :optimized_images, :created_at, :datetime, null: true
    add_column :optimized_images, :updated_at, :datetime, null: true

    # Start by stealing created/updated at from the uploads table
    # Not perfect, but a good approximation
    # TODO FIX
    # execute <<~SQL
    #   UPDATE optimized_images
    #   SET created_at = uploads.created_at,
    #       updated_at = uploads.created_at
    #   FROM uploads
    #   WHERE uploads.id = optimized_images.upload_id
    # SQL

    # # Integrity is not enforced, we might have optimized images
    # # with no uploads
    # execute <<~SQL
    #   UPDATE optimized_images
    #   SET created_at = NOW(),
    #       updated_at = NOW()
    #   WHERE created_at IS NULL
    # SQL

    execute <<~SQL
      ALTER TABLE optimized_images modify COLUMN created_at datetime NOT NULL;
    SQL

    execute <<~SQL
      ALTER TABLE optimized_images modify COLUMN updated_at datetime NOT NULL;
    SQL
  end
end
