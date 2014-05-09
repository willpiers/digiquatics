class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :location_id
      t.string  :name
      t.timestamps
    end
  end
end
