class CreatePrivateLessons < ActiveRecord::Migration
  def change
    create_table :private_lessons do |t|
      t.string :first_name
      t.string :email

      t.timestamps
    end
  end
end
