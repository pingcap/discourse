# frozen_string_literal: true

class RemoveKeyFromUserApiKey < ActiveRecord::Migration[6.0]
  DROPPED_COLUMNS ||= {
    user_api_keys: %i{key}
  }

  def up
    remove_index :user_api_keys, :key
    DROPPED_COLUMNS.each do |table, columns|
      columns.each do |column|
        remove_column table, column
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
