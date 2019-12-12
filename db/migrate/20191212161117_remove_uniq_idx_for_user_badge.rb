class RemoveUniqIdxForUserBadge < ActiveRecord::Migration[5.2]
  def change
    remove_index :user_badges, name: 'index_user_badges_on_badge_id_and_user_id_and_seq'
  end
end
