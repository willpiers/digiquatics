class AddSecondaryPhoneToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :secondary_phone_number, :string
  end
end
