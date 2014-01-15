class Position < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  has_many :users
end
