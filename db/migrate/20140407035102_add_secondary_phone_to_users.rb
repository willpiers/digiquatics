class AddSecondaryPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secondary_phone_number, :string
  end
end
