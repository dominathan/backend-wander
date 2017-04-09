class AddDataToPlace < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :data, :jsonb
  end
end
