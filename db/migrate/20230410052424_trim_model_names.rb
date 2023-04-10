class TrimModelNames < ActiveRecord::Migration[7.0]
  def change
    rename_table :gathering_outings, :outings
    rename_table :gathering_outing_groups, :groups
    rename_table :gathering_outing_group_accounts, :group_members
  end
end
