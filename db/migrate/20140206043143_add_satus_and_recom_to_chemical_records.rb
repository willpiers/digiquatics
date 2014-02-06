class AddSatusAndRecomToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :si_status, :text
    add_column :chemical_records, :si_recommendation, :text
  end
end
