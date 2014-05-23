class AddLocationIdToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :location_id, :integer
  end
end
