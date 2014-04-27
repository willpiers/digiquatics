class ChangePayRateToDecimal < ActiveRecord::Migration
  def change
    remove_column :users, :payrate, :integer
    add_column    :users, :payrate, :decimal, precision: 4, scale: 2
  end
end
