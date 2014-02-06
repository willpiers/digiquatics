class AddNewFieldsToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :queue_status, :boolean
    add_column :private_lessons, :lesson_objective, :text
  end
end
