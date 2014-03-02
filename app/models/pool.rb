class Pool < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :location
  has_many :chemical_records

  scope :same_location_as, -> (user) { where(location_id: user.location_id) }
end
