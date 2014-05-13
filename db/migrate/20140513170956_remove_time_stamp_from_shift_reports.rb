class RemoveTimeStampFromShiftReports < ActiveRecord::Migration
  def change
    remove_column :shift_reports, :time_stamp
  end
end
