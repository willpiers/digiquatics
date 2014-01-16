class CreateShiftReports < ActiveRecord::Migration
  def change
    create_table :shift_reports do |t|
      t.string :post_title

      t.timestamps
    end
  end
end
