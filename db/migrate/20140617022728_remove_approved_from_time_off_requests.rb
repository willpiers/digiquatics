class RemoveApprovedFromTimeOffRequests < ActiveRecord::Migration
  def change
    remove_column :time_off_requests, :approved
    add_column :time_off_requests, :approved, :boolean, default: false
  end
end
