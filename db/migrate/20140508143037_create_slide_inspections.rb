class CreateSlideInspections < ActiveRecord::Migration
  def change
    create_table :slide_inspections do |t|
      t.integer :slide_id
      t.integer :user_id

      t.timestamps
    end
  end
end
