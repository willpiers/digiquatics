class AddAvailabilityToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :sunday_morning, :boolean
    add_column :private_lessons, :sunday_afternoon, :boolean
    add_column :private_lessons, :sunday_evening, :boolean
    add_column :private_lessons, :monday_morning, :boolean
    add_column :private_lessons, :monday_afternoon, :boolean
    add_column :private_lessons, :monday_evening, :boolean
    add_column :private_lessons, :tuesday_morning, :boolean
    add_column :private_lessons, :tuesday_afternoon, :boolean
    add_column :private_lessons, :tuesday_evening, :boolean
    add_column :private_lessons, :wednesday_morning, :boolean
    add_column :private_lessons, :wednesday_afternoon, :boolean
    add_column :private_lessons, :wednesday_evening, :boolean
    add_column :private_lessons, :thursday_morning, :boolean
    add_column :private_lessons, :thursday_afternoon, :boolean
    add_column :private_lessons, :thursday_evening, :boolean
    add_column :private_lessons, :friday_morning, :boolean
    add_column :private_lessons, :friday_afternoon, :boolean
    add_column :private_lessons, :friday_evening, :boolean
    add_column :private_lessons, :saturday_morning, :boolean
    add_column :private_lessons, :saturday_afternoon, :boolean
    add_column :private_lessons, :saturday_evening, :boolean
  end
end
