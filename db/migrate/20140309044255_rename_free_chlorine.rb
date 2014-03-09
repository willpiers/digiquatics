class RenameFreeChlorine < ActiveRecord::Migration
  def change
    rename_column :chemical_records, :free_chlorine, :free_chlorine_ppm
  end
end
