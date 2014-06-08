class AddEmailToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :user_email, :string
    add_column :email_groups, :user_id, :integer
    add_column :email_groups, :account_id, :integer
  end
end
