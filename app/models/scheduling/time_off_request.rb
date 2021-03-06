class TimeOffRequest < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :user
  belongs_to :location

  validates_presence_of :user_id, :starts_at, :ends_at
end
