class AddPrivateLessonsAccessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_lesson_access, :boolean, deafult: false
  end
end
