class AddPoolIdToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :pool_id, :integer
  end
end
