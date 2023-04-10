class DropTimestampsOnAccounts < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :created_at
    remove_column :accounts, :updated_at
  end
end
