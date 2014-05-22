class AddClaimedClosedToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :claimed_on, :datetime
    add_column :private_lessons, :completed_on, :datetime
  end
end
