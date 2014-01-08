class AddFemalesizesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :femalesuit, :integer
  end
end
