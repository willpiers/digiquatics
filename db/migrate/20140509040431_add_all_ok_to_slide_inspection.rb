class AddAllOkToSlideInspection < ActiveRecord::Migration
  def change
    add_column :slide_inspections, :all_ok, :boolean, default: false
  end
end
