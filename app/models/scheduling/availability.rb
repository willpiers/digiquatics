class Availability < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :user

  validates_presence_of :user_id
end
