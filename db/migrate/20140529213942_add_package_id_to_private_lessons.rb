class AddPackageIdToPrivateLessons < ActiveRecord::Migration
  def change
    add_column :private_lessons, :package_id, :integer
  end
end
