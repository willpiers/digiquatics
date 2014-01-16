class AddLocationToShiftReports < ActiveRecord::Migration
  def change
    add_column :shift_reports, :location_id, :integer
  end
end
