class ChangeAssignedUserIdToUserId < ActiveRecord::Migration
  def change
  	remove_column :private_lessons, :assigned_user_id
  	add_column :private_lessons, :user_id, :integer
  end
end
