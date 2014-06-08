class AddBooleanEmailValuesToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :slides_group_email, :boolean, default: false
    add_column :accounts, :slides_admin_email, :boolean, default: false
    add_column :accounts, :slides_location_email, :boolean, default: false
  end
end
