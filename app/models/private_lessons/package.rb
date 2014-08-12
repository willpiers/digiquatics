class Package < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  has_many :private_lessons

  validates_presence_of :name, :account_id
end
