class AddChemicalEmailValuesToAccount < ActiveRecord::Migration
  def change
    add_column :chemical_records, :chemical_records_group_email, :boolean, default: false
    add_column :chemical_records, :hemical_records_admin_email, :boolean, default: false
    add_column :chemical_records, :hemical_records_location_email, :boolean, default: false
  end
end
