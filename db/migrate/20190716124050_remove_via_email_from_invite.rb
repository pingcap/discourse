# frozen_string_literal: true

require 'migration/column_dropper'

class RemoveViaEmailFromInvite < ActiveRecord::Migration[5.2]
  DROPPED_COLUMNS ||= {
    invites: %i{via_email}
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
