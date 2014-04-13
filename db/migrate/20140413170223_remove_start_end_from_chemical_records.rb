class RemoveStartEndFromChemicalRecords < ActiveRecord::Migration
  def change
    remove_column :chemical_records, :start_date
    remove_column :chemical_records, :end_date
  end
end
