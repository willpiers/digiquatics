class AddActiveToTimeOffRequests < ActiveRecord::Migration
  def change
    remove_column :time_off_requests, :integer
    add_column :time_off_requests, :active, :boolean, default: true
  end
end
