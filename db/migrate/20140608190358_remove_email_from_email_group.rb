class RemoveEmailFromEmailGroup < ActiveRecord::Migration
  def change
    remove_column :email_groups, :email
  end
end
