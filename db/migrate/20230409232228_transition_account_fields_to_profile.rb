class TransitionAccountFieldsToProfile < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :name
    remove_column :accounts, :company

    add_column :accounts, :profile_id, :bigint
    add_foreign_key :accounts, :profiles
  end
end
