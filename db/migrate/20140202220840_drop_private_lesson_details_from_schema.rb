class DropPrivateLessonDetailsFromSchema < ActiveRecord::Migration
  def change
    drop_table :private_lesson_details
  end
end
