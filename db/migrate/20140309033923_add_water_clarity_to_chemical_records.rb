class AddWaterClarityToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :water_clarity, :string
  end
end
