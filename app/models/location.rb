class Location < ActiveRecord::Base
	belongs_to :account
	has_many :users
end
