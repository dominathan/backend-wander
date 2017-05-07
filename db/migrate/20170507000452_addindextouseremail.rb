class Addindextouseremail < ActiveRecord::Migration[5.0]
  def change
    if Rails.env != "development"
      add_index :users, :email
    end
  end
end
