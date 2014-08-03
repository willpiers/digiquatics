class ChangeAvailabilityTimesToDatetime < ActiveRecord::Migration
  def up
    change_column :availabilities, :start_time, :datetime
    change_column :availabilities, :end_time, :datetime
  end

  def down
    change_column :availabilities, :start_time, :time
    change_column :availabilities, :end_time, :time
  end
end
