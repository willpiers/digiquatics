class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :private_lesson_id
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.integer :age
      t.string :instructor_gender
      t.text :notes
      t.text :lesson_objective
    end
  end
end
