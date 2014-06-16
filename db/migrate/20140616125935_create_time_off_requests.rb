class CreateTimeOffRequests < ActiveRecord::Migration
  def change
    create_table :time_off_requests do |t|
      t.integer :user_id
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :reason
      t.boolean :approved
      t.string :approved_by_user_id
      t.string :integer
      t.datetime :approved_at

      t.timestamps
    end
  end
end
