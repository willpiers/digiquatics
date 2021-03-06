class Position < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  has_many :users
  has_many :shifts

  validates_presence_of :name, :account_id
end
