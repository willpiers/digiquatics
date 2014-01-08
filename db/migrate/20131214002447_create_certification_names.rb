class CreateCertificationNames < ActiveRecord::Migration
  def change
    create_table :certification_names do |t|
      t.integer :account_id
      t.string :name

      t.timestamps
    end
  end
end
