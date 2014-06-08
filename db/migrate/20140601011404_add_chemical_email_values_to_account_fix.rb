class AddChemicalEmailValuesToAccountFix < ActiveRecord::Migration
  def change
    remove_column :chemical_records, :chemical_records_group_email, :boolean, default: false
    remove_column :chemical_records, :chemical_records_admin_email, :boolean, default: false
    remove_column :chemical_records, :chemical_records_location_email, :boolean, default: false
    add_column :accounts, :chemical_records_group_email, :boolean, default: false
    add_column :accounts, :chemical_records_admin_email, :boolean, default: false
    add_column :accounts, :chemical_records_location_email, :boolean, default: false
  end
end
