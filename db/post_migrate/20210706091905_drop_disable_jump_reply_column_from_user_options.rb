# frozen_string_literal: true

class DropDisableJumpReplyColumnFromUserOptions < ActiveRecord::Migration[6.1]
  DROPPED_COLUMNS ||= {
    user_options: %i{disable_jump_reply}
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
