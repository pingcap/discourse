class FixWebhookResponseHeader < ActiveRecord::Migration[5.2]
  def change
    change_column :web_hook_events, :response_headers, :text
  end
end
