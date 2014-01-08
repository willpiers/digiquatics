class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.belongs_to :account
      t.string :name
      t.integer :account_id

      t.timestamps
    end
  end
end
