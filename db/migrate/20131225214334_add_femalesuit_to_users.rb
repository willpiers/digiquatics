class AddFemalesuitToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :integer
  end
end
