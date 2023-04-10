class AddLatLongToGathering < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :latitude, :decimal, precision: 18, scale: 15
    add_column :gatherings, :longitude, :decimal, precision: 18, scale: 15
  end
end
