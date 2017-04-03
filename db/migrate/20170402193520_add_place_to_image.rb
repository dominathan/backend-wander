class AddPlaceToImage < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :place, index: true
  end
end
