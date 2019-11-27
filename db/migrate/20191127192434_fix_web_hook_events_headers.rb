class FixWebHookEventsHeaders < ActiveRecord::Migration[5.2]
  def change
    change_column :web_hook_events, :headers, :text
  end
end
