class AddLogoToAccounts < ActiveRecord::Migration
  def change
    add_attachment :accounts, :logo
  end
end
