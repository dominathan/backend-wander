class CreateGroupPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :group_places do |t|
      t.references :group, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
