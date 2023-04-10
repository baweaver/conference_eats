class CleanupModelFields < ActiveRecord::Migration[7.0]
  def change
    rename_table :gathering_accounts, :gathering_members

    rename_column :group_members, :gathering_outing_group_id, :group_id
    add_index :group_members, :group_id

    rename_column :groups, :gathering_outing_id, :outing_id
  end
end
