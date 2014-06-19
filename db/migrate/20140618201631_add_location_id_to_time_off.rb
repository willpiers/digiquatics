class AddLocationIdToTimeOff < ActiveRecord::Migration
  def change
    add_column :time_off_requests, :location_id, :integer
  end
end
