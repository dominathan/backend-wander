class AddLatLngToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :lat, :float
    add_column :groups, :lng, :float
    add_column :groups, :city, :string
  end
end
