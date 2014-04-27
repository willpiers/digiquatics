class Pool < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :location
  has_many :chemical_records

  scope :same_account_as, (lambda do |user|
    where(location_id: user.account.locations.map(&:id))
  end)

  scope :same_location_as, -> (user) { where(location_id: user.location_id) }

  def full_name
   "#{location_id} - #{name}"
  end
end
