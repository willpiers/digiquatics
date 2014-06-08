class AddChemicalMinMaxToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :total_chlorine_max, :integer
  end
end
