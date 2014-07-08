class AddStuffToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :day,        :integer
    add_column :availabilities, :start_time, :time
    add_column :availabilities, :end_time,   :time
  end
end
