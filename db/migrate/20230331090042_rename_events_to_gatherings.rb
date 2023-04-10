class RenameEventsToGatherings < ActiveRecord::Migration[7.0]
  def change
    rename_table :events, :gatherings
    rename_table :event_outings, :gathering_outings
    rename_table :event_outing_groups, :gathering_outing_groups
    rename_table :event_outing_group_users, :gathering_outing_group_users
    rename_table :event_users, :gathering_users
  end
end
