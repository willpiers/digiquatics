class AddMaintBooleanEmailValuesToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :maintenance_group_email, :boolean, default: false
    add_column :accounts, :maintenance_admin_email, :boolean, default: false
    add_column :accounts, :maintenance_location_email, :boolean, default: false
  end
end
