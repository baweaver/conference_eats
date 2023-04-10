class CreateEventOutingGroupUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :event_outing_group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event_outing_group, null: false, foreign_key: true
      t.string :status
      t.date :status_updated_at

      t.timestamps
    end
  end
end
