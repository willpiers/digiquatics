class CreateSkillLevels < ActiveRecord::Migration
  def change
    create_table :skill_levels do |t|
      t.integer :account_id
      t.string :name
    end
  end
end
