class AddAttachmentToPrivateLessons < ActiveRecord::Migration
  def change
    add_attachment :private_lessons, :attachment
  end
end
