# frozen_string_literal: true

class DropAutomaticMembershipRetroactiveFromGroup < ActiveRecord::Migration[6.0]
  DROPPED_COLUMNS ||= {
    groups: %i{
      automatic_membership_retroactive
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
