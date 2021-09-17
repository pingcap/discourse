# frozen_string_literal: true

class DropUploadsVerified < ActiveRecord::Migration[6.1]
  DROPPED_COLUMNS ||= {
    uploads: %i{verified}
  }

  def up
    DROPPED_COLUMNS.each do |table, columns|
      columns.each do |column|
        remove_column table, column
      end
    end
  end

  def down
    add_column :uploads, :verified, :string
  end
end
