class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.integer :certification_name_id
      t.integer :user_id
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
