class AddNotesToSlideInspection < ActiveRecord::Migration
  def change
    add_column :slide_inspections, :notes, :text
  end
end
