class CreateDailyTodos < ActiveRecord::Migration
  def change
    create_table :daily_todos do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
