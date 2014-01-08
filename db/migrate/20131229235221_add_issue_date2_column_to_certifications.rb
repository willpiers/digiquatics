class AddIssueDate2ColumnToCertifications < ActiveRecord::Migration
  def change
  	add_column :certifications, :issue_date, :datetime
  end
end
