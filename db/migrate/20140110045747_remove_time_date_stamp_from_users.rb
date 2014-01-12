class RemoveTimeDateStampFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :date_time_reading
  end
end
