class AddColumnNumLessonsToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :number_lessons, :integer
  end
end
