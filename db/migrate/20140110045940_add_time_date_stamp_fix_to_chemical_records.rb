class AddTimeDateStampFixToChemicalRecords < ActiveRecord::Migration
  def change
  	add_column :chemical_records, :date_time_reading, :datetime
  end
end
