class DefaultBooleansSubRequests < ActiveRecord::Migration
  def change
    remove_column :sub_requests, :approved
    remove_column :sub_requests, :active
    add_column :sub_requests, :approved, :boolean, default: false
    add_column :sub_requests, :active, :boolean, default: true
  end
end
