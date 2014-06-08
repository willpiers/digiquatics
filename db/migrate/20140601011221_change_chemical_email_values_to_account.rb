class ChangeChemicalEmailValuesToAccount < ActiveRecord::Migration
  def change
    remove_column :chemical_records, :hemical_records_admin_email
    remove_column :chemical_records, :hemical_records_location_email
    add_column :chemical_records, :chemical_records_admin_email, :boolean, default: false
    add_column :chemical_records, :chemical_records_location_email, :boolean, default: false
  end
end
