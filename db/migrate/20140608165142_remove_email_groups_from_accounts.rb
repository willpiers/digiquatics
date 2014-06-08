class RemoveEmailGroupsFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :email_group
    remove_column :accounts, :total_chlorine_max
  end
end
