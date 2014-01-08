class AddFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :sex, :string
  	add_column :users, :date_of_birth, :datetime
  	add_column :users, :date_of_hire, :datetime
  	add_column :users, :phone_number, :integer
  end
end
