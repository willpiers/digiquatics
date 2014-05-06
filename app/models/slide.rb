class Slide < ActiveRecord::Base
  belongs_to :location

  validates_presence_of :name
end
