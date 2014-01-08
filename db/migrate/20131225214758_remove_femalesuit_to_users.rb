class RemoveFemalesuitToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :description, :integer
  end
end
