class RemoveTypeFromHelpDesk < ActiveRecord::Migration
  def change
    remove_column :help_desks, :type
    add_column :help_desks, :urgency, :string
    add_column :help_desks, :user_id, :integer
    add_column :help_desks, :location_id, :integer
    add_column :help_desks, :status, :boolean
  end
end
