class ChangeApprovedToDefaultNull < ActiveRecord::Migration
  def change
    remove_column :sub_requests, :approved
    add_column :sub_requests, :approved, :boolean
  end
end
