class RemoveDateStampFromShiftReports < ActiveRecord::Migration
  def change
    remove_column :shift_reports, :date_stamp
    remove_column :shift_reports, :time_stamp
    add_column :shift_reports, :time_stamp, :datetime
  end
end
