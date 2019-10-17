class InitView < ActiveRecord::Migration[5.2]
  def up
    BadgePostsViewManager.create!
  end

  def down
    BadgePostsViewManager.drop!
  end
end
