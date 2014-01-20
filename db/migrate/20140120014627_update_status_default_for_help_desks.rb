class UpdateStatusDefaultForHelpDesks < ActiveRecord::Migration
  def change
    change_column :help_desks, :issue_status, :boolean, default: true
  end
end
