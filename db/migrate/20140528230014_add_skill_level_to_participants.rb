class AddSkillLevelToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :skill_level, :integer
  end
end
