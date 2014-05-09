class CreateSlideInspectionTasks < ActiveRecord::Migration
  def change
    create_table :slide_inspection_tasks do |t|
      t.integer :slide_inspection_id
      t.string :task_name
      t.boolean :completed

      t.timestamps
    end
  end
end
