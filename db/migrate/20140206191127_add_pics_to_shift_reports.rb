class AddPicsToShiftReports < ActiveRecord::Migration
  def change
    add_attachment :shift_reports, :attachment_front
    add_attachment :shift_reports, :attachment_back
  end
end
