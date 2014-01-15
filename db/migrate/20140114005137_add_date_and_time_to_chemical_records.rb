class AddDateAndTimeToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :date_stamp, :date
    add_column :chemical_records, :time_stamp, :time
    remove_column :chemical_records, :date_time_reading
  end
end
