class AddCombinedChlorinePpmToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :combined_chlorine_ppm, :decimal, precision: 6, scale: 2
  end
end
