class AddTimeZoneToAccount < ActiveRecord::Migration
  def change
  	remove_column :users, :time_zone
    add_column :accounts, :time_zone, :string
  end
end
