class CertificationName < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :certifications
end
