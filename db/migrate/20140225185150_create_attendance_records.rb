class CreateAttendanceRecords < ActiveRecord::Migration
  def change
    create_table :attendance_records do |t|
      t.string :name

      t.timestamps
    end
  end
end
