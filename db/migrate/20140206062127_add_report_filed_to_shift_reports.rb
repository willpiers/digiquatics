class AddReportFiledToShiftReports < ActiveRecord::Migration
  def change
    add_column :shift_reports, :report_filed, :boolean
  end
end
