class RemoveUniqIdx8 < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_emails, name: :index_user_emails_on_user_id_and_primary
  end
end
