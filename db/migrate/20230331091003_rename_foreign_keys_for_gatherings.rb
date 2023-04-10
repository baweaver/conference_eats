class RenameForeignKeysForGatherings < ActiveRecord::Migration[7.0]
  def change
    add_column :gathering_outings, :gathering_id, :string
    add_index :gathering_outings, :gathering_id

    rename_column :gathering_users, :event_id, :gathering_id
    rename_column :gathering_outing_groups, :event_outing_id, :gathering_outing_id
    rename_column :gathering_outing_group_users, :event_outing_group_id, :gathering_outing_group_id
  end
end
