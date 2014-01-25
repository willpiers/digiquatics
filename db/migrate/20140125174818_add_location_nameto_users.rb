class AddLocationNametoUsers < ActiveRecord::Migration
  def change
    add_column :users, :emergency_first, :string
    add_column :users, :emergency_last, :string
    add_column :users, :emergency_phone, :string
    add_column :users, :nickname, :string
    add_column :users, :payrate, :integer
    add_column :users, :grouping, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :integer
  end
end
