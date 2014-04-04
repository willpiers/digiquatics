class RemoveStudentAttributesFromPrivateLessons < ActiveRecord::Migration
  def change
    remove_column :private_lessons, :string
    remove_column :private_lessons, :first_name
    remove_column :private_lessons, :last_name
    remove_column :private_lessons, :sex
    remove_column :private_lessons, :age
    remove_column :private_lessons, :instructor_gender
    remove_column :private_lessons, :notes
    remove_column :private_lessons, :lesson_objective
  end
end
