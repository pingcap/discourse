class FixLengthForPostRevisions < ActiveRecord::Migration[5.2]
  def change
    change_column :post_revisions, :modifications, :longtext
    change_column :user_histories, :details, :longtext
    change_column :posts, :raw, :longtext
    change_column :posts, :cooked, :longtext
  end
end
