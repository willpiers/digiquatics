class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :user_id
      t.integer :location_id
      t.integer :position_id
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
