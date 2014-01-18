class AddNewColumnToPrivateLessonDetails < ActiveRecord::Migration
  def change
    add_column :private_lesson_details, :first_name, :string
    add_column :private_lesson_details, :last_name, :string
    add_column :private_lesson_details, :email, :string
    add_column :private_lesson_details, :phone_number, :integer
    add_attachment :private_lesson_details, :attachment

  end
end
