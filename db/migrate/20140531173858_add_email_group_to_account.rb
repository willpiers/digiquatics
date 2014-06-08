class AddEmailGroupToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :email_group, :text, array: true
  end
end
