class ChangeShirtName < ActiveRecord::Migration
  def change
    remove_column :users, :shit_size
    add_column :users, :shirt_size, :string
  end
end
