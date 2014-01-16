class AddUserIdToShiftReports < ActiveRecord::Migration
  def change
    add_column :shift_reports, :user_id, :integer
  end
end
