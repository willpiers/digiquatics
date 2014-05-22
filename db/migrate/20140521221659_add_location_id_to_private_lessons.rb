class AddLocationIdToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :location_id, :integer
  end
end
