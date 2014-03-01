class AddAccountIdToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :account_id, :integer
  end
end
