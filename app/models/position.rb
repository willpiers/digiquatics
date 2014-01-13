class Position < ActiveRecord::Base
  belongs_to :account
  has_many :users
end
