class AddColumnToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :last_name, :string
  end
end
