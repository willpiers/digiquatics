class RemoveDayAndTimeFromPrivateLessons < ActiveRecord::Migration
  def change
    remove_column :private_lessons, :day
    remove_column :private_lessons, :time
  end
end
