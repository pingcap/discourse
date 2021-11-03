# frozen_string_literal: true

class DropTopicReplyCount < ActiveRecord::Migration[6.0]
  DROPPED_COLUMNS ||= {
    user_stats: %i{
      topic_reply_count
    }
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
