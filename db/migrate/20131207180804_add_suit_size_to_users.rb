class AddSuitSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suit_size, :string
    add_column :users, :shit_size, :string
  end
end
