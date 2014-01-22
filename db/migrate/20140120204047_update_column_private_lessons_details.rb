class UpdateColumnPrivateLessonsDetails < ActiveRecord::Migration
  def change
    remove_attachment :private_lesson_details, :attachment
    add_attachment :private_lesson_details, :logo
  end
end
