class Certification < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification_name
  belongs_to :account
end
