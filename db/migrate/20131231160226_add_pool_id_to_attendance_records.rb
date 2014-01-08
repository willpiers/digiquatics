class AddPoolIdToAttendanceRecords < ActiveRecord::Migration
  def change
  	add_column :attendance_records, :pool_id, :integer
  end
end
