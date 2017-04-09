class CreatePlaceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :place_types do |t|
      t.references :type, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
