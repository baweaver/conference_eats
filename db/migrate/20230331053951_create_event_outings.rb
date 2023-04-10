class CreateEventOutings < ActiveRecord::Migration[7.0]
  def change
    create_table :event_outings do |t|
      t.string :name
      t.date :start_time
      t.date :end_time
      t.text :description

      t.timestamps
    end
  end
end
