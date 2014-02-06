class AddUserIdAndDateTimeStampToHelpDesk < ActiveRecord::Migration
  def change
    add_column :help_desks, :closed_user_id, :integer
    add_column :help_desks, :closed_date_time, :datetime
  end
end
