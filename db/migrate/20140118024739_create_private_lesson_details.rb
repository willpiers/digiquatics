class CreatePrivateLessonDetails < ActiveRecord::Migration
  def change
    create_table :private_lesson_details do |t|

      t.timestamps
    end
  end
end
