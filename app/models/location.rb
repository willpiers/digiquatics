class Location < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  validates :account_id, presence: true
  validates :name, presence: true
  belongs_to :account
  has_many :users
  has_many :shift_reports
end
