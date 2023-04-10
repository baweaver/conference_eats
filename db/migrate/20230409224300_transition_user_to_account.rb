class TransitionUserToAccount < ActiveRecord::Migration[7.0]
  def change
    remove_index :gathering_users, :user_id
    remove_index :gathering_users, :gathering_id
    remove_index :gathering_outing_group_users, :gathering_outing_group_id

    rename_table :gathering_users, :gathering_accounts
    rename_table :gathering_outing_group_users, :gathering_outing_group_accounts

    # remove_index :gathering_users, :user_id
    # remove_index :gathering_outing_group_users, :user_id

    # Index names too long, rename_column can't handle this
    remove_column :gathering_accounts, :user_id
    add_column :gathering_accounts, :account_id, :bigint
    add_index :gathering_accounts, :account_id # , name: 'index_ga_account_id'

    remove_column :gathering_outing_group_accounts, :user_id
    add_column :gathering_outing_group_accounts, :account_id, :bigint
    add_index :gathering_outing_group_accounts, :account_id # , name: 'index_goga_account_id'

    drop_table :users
  end
end
