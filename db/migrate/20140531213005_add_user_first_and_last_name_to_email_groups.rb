class AddUserFirstAndLastNameToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :user_first_name, :string
    add_column :email_groups, :user_last_name, :string
  end
end
