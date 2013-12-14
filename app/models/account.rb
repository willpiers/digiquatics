class Account < ActiveRecord::Base
  has_many :certification_names
  has_many :users
  has_many :certifications, through: :certification_names
end
