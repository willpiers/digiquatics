class CreateAttendanceRecords < ActiveRecord::Migration
  def change
    create_table :attendance_records do |t|
      t.integer :t0500_0600
      t.integer :t0600_0700
      t.integer :t0700_0800
      t.integer :t0800_0900
      t.integer :t0900_1000
      t.integer :t1000_1100
      t.integer :t1100_1200
      t.integer :pool_id

      t.timestamps
    end
  end
end
