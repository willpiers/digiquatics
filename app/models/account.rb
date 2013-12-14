class Account < ActiveRecord::Base
  has_many :certification_names
  has_many :users
end
