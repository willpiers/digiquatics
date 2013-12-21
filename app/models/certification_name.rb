class CertificationName < ActiveRecord::Base
  validates :account_id, presence: true
  validates :name, presence: true
  accepts_nested_attributes_for :certifications

  belongs_to :account
  has_many :certifications
end
