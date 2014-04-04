class AddLessonPreferenceFieldsToPrivateLesson < ActiveRecord::Migration
  def change
    remove_column :participants, :instructor_gender
    remove_column :participants, :notes
    remove_column :participants, :lesson_objective
    add_column :private_lessons, :instructor_gender, :string
    add_column :private_lessons, :notes, :text
    add_column :private_lessons, :lesson_objective, :text
  end
end
