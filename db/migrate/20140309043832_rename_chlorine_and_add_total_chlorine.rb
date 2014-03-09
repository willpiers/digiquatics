class RenameChlorineAndAddTotalChlorine < ActiveRecord::Migration
  def change
    rename_column :chemical_records, :chlorine_ppm, :free_chlorine
    add_column :chemical_records, :total_chlorine_ppm, :decimal, precision: 6, scale: 2
  end
end
