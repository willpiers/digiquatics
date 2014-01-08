class CreateChemicalRecords < ActiveRecord::Migration
  def change
    create_table :chemical_records do |t|
      t.decimal :chlorine_ppm
      t.decimal :chlorine_orp
      t.decimal :ph
      t.decimal :alkalinity
      t.decimal :calcium_hardness
      t.decimal :pool_temp
      t.decimal :air_temp
      t.decimal :si_index

      t.timestamps
    end
  end
end
