class AddAssignedUserIdColumnToPrivateLessons < ActiveRecord::Migration
  def change
  	add_column :private_lessons, :assigned_user_id, :integer
  end
end
