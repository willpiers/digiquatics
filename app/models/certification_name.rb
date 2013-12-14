class CertificationName < ActiveRecord::Base
  belongs_to :account
  has_many :certifications
end
