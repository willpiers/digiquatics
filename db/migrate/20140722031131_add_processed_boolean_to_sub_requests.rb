class AddProcessedBooleanToSubRequests < ActiveRecord::Migration
  def change
    add_column :sub_requests, :processed, :boolean, default: false
  end
end
