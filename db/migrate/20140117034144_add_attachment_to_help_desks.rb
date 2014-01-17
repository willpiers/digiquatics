class AddAttachmentToHelpDesks < ActiveRecord::Migration
  def change
    add_attachment :help_desks, :help_desk_attachment
  end
end
