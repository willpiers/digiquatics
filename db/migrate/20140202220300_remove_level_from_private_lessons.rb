class RemoveLevelFromPrivateLessons < ActiveRecord::Migration
  def change
    remove_column :private_lessons, :ability_level
    remove_column :private_lessons, :facility_level
  end
end
