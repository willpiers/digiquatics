class RemoveNumberLessonsFromPrivateLessons < ActiveRecord::Migration
  def change
    remove_column :private_lessons, :number_lessons
  end
end
