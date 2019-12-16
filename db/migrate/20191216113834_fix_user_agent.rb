class FixUserAgent < ActiveRecord::Migration[5.2]
  def change
    change_column :user_auth_tokens, :user_agent, :text
    change_column :user_auth_token_logs, :user_agent, :text
  end
end
