class AddLocationToGathering < ActiveRecord::Migration[7.0]
  def change
    add_column :gatherings, :location, 'string'
  end
end
