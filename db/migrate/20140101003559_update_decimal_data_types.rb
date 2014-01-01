class UpdateDecimalDataTypes < ActiveRecord::Migration
  def change
  	change_column :chemical_records, :chlorine_ppm, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :chlorine_orp, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :ph, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :alkalinity, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :calcium_hardness, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :pool_temp, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :air_temp, :decimal, precision: 4, scale: 2
  	change_column :chemical_records, :si_index, :decimal, precision: 4, scale: 2
  end
end
