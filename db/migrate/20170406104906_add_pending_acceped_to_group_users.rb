class AddPendingAccepedToGroupUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :pending, :boolean
    add_column :group_users, :accepted, :boolean
  end
end
