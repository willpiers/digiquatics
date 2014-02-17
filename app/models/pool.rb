class Pool < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :location
  has_many :chemical_records

end
