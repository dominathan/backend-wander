class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.references :friendable, polymorphic: true
      t.integer  :friend_id
      t.string   :status

      t.timestamps
    end
    add_index :friendships, :friend_id, name: "friend_id_ix"
  end

  def self.down
    drop_index :friendships, :friend_id
    drop_table :friendships
  end
end
