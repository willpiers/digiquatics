class DropAttendanceRecords < ActiveRecord::Migration
  def change
    drop_table :attendance_records
  end
end
