# frozen_string_literal: true

class DropPathWhitelistFromEmbeddableHosts < ActiveRecord::Migration[6.0]
  DROPPED_COLUMNS ||= {
    embeddable_hosts: %i{path_whitelist}
  }

  def up
    DROPPED_COLUMNS.each do |table, columns|
      columns.each do |column|
        remove_column table, column
      end
    end
  end

  def down
    add_column :embeddable_hosts, :path_whitelist, :string
  end
end
