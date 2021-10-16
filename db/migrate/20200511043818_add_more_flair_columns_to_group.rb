# frozen_string_literal: true

class AddMoreFlairColumnsToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :flair_icon, :string
    add_column :groups, :flair_upload_id, :integer

    reversible do |dir|
      dir.up do
        DB.exec(
          <<~SQL
            UPDATE `groups` SET flair_icon = REPLACE(REPLACE(flair_url, 'fas fa-', ''), ' fa-', '-')
            WHERE flair_url LIKE 'fa%'
          SQL
        )

        DB.exec(
          <<~SQL
            UPDATE `groups` g1
            JOIN `groups` g2 ON g1.id = g2.id
            INNER JOIN uploads u ON g2.flair_url regexp CONCAT('\\/', u.sha1, '[\\.\\w]*')
            SET flair_upload_id = u.id
          SQL
        )

        DB.exec(
          <<~SQL
            UPDATE `groups` SET flair_url = NULL
            WHERE flair_icon IS NOT NULL OR flair_upload_id IS NOT NULL
          SQL
        )
      end
    end
  end
end
