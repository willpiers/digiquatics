class AddIssueRolustionTextToHelpDesks < ActiveRecord::Migration
  def change
    add_column :help_desks, :issue_reolustion_text, :text
  end
end
