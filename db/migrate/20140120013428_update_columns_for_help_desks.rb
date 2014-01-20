class UpdateColumnsForHelpDesks < ActiveRecord::Migration
  def change
    add_column :help_desks, :issue_status, :boolean
    remove_column :help_desks, :status
  end
end
