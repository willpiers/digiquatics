class CertificationName < ActiveRecord::Base
  validates :account_id, presence: true
  validates :name, presence: true

  belongs_to :account
  has_many :certifications
end
