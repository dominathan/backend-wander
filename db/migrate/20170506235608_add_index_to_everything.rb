class AddIndexToEverything < ActiveRecord::Migration[5.0]
  def change
    add_index :friendships, :friendable_id
    add_index :groups, :name
    add_index :groups, :owner_id
    add_index :likes, :friend_id
    add_index :places, :lat
    add_index :places, :lng
    add_index :places, :name
    add_index :users, :first_name
    add_index :users, :last_name
  end
end
