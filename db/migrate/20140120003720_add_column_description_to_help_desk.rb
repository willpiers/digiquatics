class AddColumnDescriptionToHelpDesk < ActiveRecord::Migration
  def change
    add_column :help_desks, :description, :text
  end
end
