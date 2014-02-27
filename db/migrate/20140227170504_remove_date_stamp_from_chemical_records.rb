class RemoveDateStampFromChemicalRecords < ActiveRecord::Migration
  def up
    remove_column :chemical_records, :date_stamp, :datetime
  end

  def down
    add_column :chemical_records, :date_stamp, :datetime
  end
end
