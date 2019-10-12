class AddTableForSelectWithoutFrom < ActiveRecord::Migration[5.2]
  def change
    execute("create table one_row_table (id int)")
    execute("insert into one_row_table values (1)")
  end
end
