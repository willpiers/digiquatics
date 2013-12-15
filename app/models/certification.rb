class Certification < ActiveRecord::Base
  # scope: account_certifications, -> { }

  belongs_to :user
  belongs_to :certification_name
  belongs_to :account
end
