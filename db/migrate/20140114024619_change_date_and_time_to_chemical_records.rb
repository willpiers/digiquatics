class ChangeDateAndTimeToChemicalRecords < ActiveRecord::Migration
  def change
    change_column :chemical_records, :date_stamp, :datetime
    change_column :chemical_records, :time_stamp, :datetime
  end
end
