class Slide < ActiveRecord::Base
  belongs_to :location
  has_many :slide_inspections

  validates_presence_of :name
end
