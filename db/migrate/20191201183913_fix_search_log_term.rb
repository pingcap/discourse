class FixSearchLogTerm < ActiveRecord::Migration[5.2]
  def change
    change_column :search_logs, :term, :text
  end
end
