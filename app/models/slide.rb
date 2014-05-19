class Slide < ActiveRecord::Base
  belongs_to :location
  has_many :slide_inspections
  has_many :accounts, through: :locations

  validates_presence_of :name
end
