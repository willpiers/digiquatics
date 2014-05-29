class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.integer :account_id
      t.string :name
    end
  end
end
