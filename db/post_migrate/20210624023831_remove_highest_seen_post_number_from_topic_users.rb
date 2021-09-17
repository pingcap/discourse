# frozen_string_literal: true

require 'migration/column_dropper'

class RemoveHighestSeenPostNumberFromTopicUsers < ActiveRecord::Migration[6.1]
  DROPPED_COLUMNS = {
    topic_users: %i{highest_seen_post_number}
  }

  def up
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
