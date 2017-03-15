class AddCityCountryToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :city, :string
    add_column :places, :country, :string
  end
end
