class AddDatesForQueryToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :start_date, :datetime
    add_column :chemical_records, :end_date, :datetime
  end
end
