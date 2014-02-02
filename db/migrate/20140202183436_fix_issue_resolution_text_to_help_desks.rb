class FixIssueResolutionTextToHelpDesks < ActiveRecord::Migration
  def change
    remove_column :help_desks, :issue_reolustion_text, :text
    add_column :help_desks, :issue_resolution_description, :text
  end
end
