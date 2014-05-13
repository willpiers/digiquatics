class RemovePostTitleFromShiftReports < ActiveRecord::Migration
  def change
    remove_column :shift_reports, :post_title
  end
end
