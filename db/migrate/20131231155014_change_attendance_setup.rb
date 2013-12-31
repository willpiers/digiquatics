class ChangeAttendanceSetup < ActiveRecord::Migration
  def change
  	drop_table :attendance_records
  	create_table :attendance_records do |t|
  		t.integer :patrons
  		t.datetime :start_time
  		t.datetime :end_time
  		t.integer :location_id

  		t.timestamps
  	end
  end
end
