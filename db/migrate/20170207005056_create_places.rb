class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :google_id
      t.string :google_place_id

      t.timestamps
    end
  end
end
