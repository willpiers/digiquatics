class RenameSkillLevelToSkillLevelId < ActiveRecord::Migration
  def change
    rename_column :participants, :skill_level, :skill_level_id
  end
end
