class AddChemicalRecordsAccessToUsers < ActiveRecord::Migration
  def change
     add_column :users, :chemical_records_access, :boolean, deafult: false
  end
end
