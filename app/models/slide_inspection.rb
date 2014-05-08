class SlideInspection < ActiveRecord::Base
  belongs_to :user
  belongs_to :slide
  has_many :slide_inspection_tasks
end
