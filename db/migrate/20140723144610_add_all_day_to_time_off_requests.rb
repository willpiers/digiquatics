class AddAllDayToTimeOffRequests < ActiveRecord::Migration
  def change
    add_column :time_off_requests, :all_day, :boolean
  end
end
