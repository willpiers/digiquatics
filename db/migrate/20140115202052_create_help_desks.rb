class CreateHelpDesks < ActiveRecord::Migration
  def change
    create_table :help_desks do |t|
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
