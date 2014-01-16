class AddCoulmnsToShiftReports < ActiveRecord::Migration
  def change
    add_column :shift_reports, :date_stamp, :date
    add_column :shift_reports, :time_stamp, :time
    add_column :shift_reports, :post_content, :text
  end
end
