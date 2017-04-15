class AddFriendToLike < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :friend_id, :integer
  end
end
