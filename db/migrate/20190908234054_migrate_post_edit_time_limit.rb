# frozen_string_literal: true

class MigratePostEditTimeLimit < ActiveRecord::Migration[5.2]
  def up
    execute <<~SQL
    INSERT  IGNORE INTO site_settings (
      name,
      value,
      data_type,
      created_at,
      updated_at
    )
      SELECT
        'tl2_post_edit_time_limit',
        value,
        data_type,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
      FROM site_settings
      WHERE
        name = 'post_edit_time_limit'
    SQL
  end
end
