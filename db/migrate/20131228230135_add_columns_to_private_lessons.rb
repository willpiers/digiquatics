class AddColumnsToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :phone_number, :string
    add_column :private_lessons, :parent_first_name, :string
    add_column :private_lessons, :parent_last_name, :string
    add_column :private_lessons, :contact_method, :string
    add_column :private_lessons, :string, :string
    add_column :private_lessons, :sex, :string
    add_column :private_lessons, :age, :integer
    add_column :private_lessons, :instructor_gender, :string
    add_column :private_lessons, :notes, :string
    add_column :private_lessons, :day, :string
    add_column :private_lessons, :time, :string
    add_column :private_lessons, :preferred_location, :string
    add_column :private_lessons, :ability_level, :integer
    add_column :private_lessons, :facility_level, :integer
  end
end
