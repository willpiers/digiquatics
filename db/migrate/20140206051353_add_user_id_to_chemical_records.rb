class AddUserIdToChemicalRecords < ActiveRecord::Migration
  def change
    add_column :chemical_records, :user_id, :integer
  end
end
