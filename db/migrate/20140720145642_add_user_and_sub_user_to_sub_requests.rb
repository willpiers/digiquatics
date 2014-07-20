class AddUserAndSubUserToSubRequests < ActiveRecord::Migration
  def change
    add_column :sub_requests, :user_id, :integer
    add_column :sub_requests, :sub_user_id, :integer
  end
end
