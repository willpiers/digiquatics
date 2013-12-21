dclass AddAttachmentPaperclip < ActiveRecord::Migration
  def change
    add_column :certifications, :attachment_file_name,    :string
    add_column :certifications, :attachment_content_type, :string
    add_column :certifications, :attachment_file_size,    :integer
    add_column :certifications, :attachment_updated_at,   :datetime
  end
end
