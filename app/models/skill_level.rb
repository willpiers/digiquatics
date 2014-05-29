class SkillLevel < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  has_many :participants

  validates_presence_of :name, :account_id
end
