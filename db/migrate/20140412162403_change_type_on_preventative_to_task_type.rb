class ChangeTypeOnPreventativeToTaskType < ActiveRecord::Migration
  def change
    remove_column :preventative_lists, :type
    add_column :preventative_lists, :task_type, :string
  end
end
