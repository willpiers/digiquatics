class AddSubFirstLastToSubRequests < ActiveRecord::Migration
  def change
    add_column :sub_requests, :sub_first_name, :string
    add_column :sub_requests, :sub_last_name, :string
  end
end
