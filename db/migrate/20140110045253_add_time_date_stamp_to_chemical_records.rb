class AddTimeDateStampToChemicalRecords < ActiveRecord::Migration
  def change
  	add_column :users, :date_time_reading, :datetime
  end
end
