class AddFirstAndLastNameToTimeOff < ActiveRecord::Migration
  def change
    add_column :time_off_requests, :processed_by_last_name, :string
    add_column :time_off_requests, :processed_by_first_name, :string
  end
end
