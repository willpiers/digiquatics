class RenamePostContentToContent < ActiveRecord::Migration
  def change
    rename_column :shift_reports, :post_content, :content
  end
end
