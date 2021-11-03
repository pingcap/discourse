# frozen_string_literal: true

class AddKeyHashToUserApiKey < ActiveRecord::Migration[6.0]
  def up
    add_column :user_api_keys, :key_hash, :string

    batch_size = 500
    loop do
      rows = DB
        .query("SELECT id, `key` FROM user_api_keys WHERE key_hash IS NULL LIMIT #{batch_size}")
        .map { |row| { id: row.id, key_hash: Digest::SHA256.hexdigest(row.key) } }

      break if rows.size == 0
      selects = rows.map do |row|
        "SELECT #{row[:id]} AS id, '#{row[:key_hash]}' AS key_hash"
      end.join(" UNION ")
      
      execute <<~SQL
        UPDATE user_api_keys
        JOIN (#{selects}) AS data ON user_api_keys.id = data.id
        SET user_api_keys.key_hash = data.key_hash
        WHERE user_api_keys.id = data.id
      SQL

      break if rows.size < batch_size
    end

    change_column_null :user_api_keys, :key_hash, false
  end

  def down
    drop_column :user_api_keys, :key_hash, :string
  end
end
