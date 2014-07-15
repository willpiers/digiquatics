class CreateSubRequests < ActiveRecord::Migration
  def change
    create_table :sub_requests do |t|
      t.integer :shift_id
      t.boolean :active
      t.boolean :approved
      t.datetime :processed_on
      t.integer :processed_by_user_id
      t.string :processed_by_first_name
      t.string :processed_by_last_name
      t.timestamps
    end
  end
end
