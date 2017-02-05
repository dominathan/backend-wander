class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.string :photo_url
      t.string :email
      t.string :gender
      t.string :facebook_id
      t.string :refresh_token
      t.string :access_token
      t.string :id_token

      t.timestamps
    end
  end
end
