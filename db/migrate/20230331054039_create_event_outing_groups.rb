class CreateEventOutingGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :event_outing_groups do |t|
      t.references :event_outing, null: false, foreign_key: true
      t.string :name
      t.string :location
      t.integer :max_size

      t.timestamps
    end
  end
end
