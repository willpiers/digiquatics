class SubRequest < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :shift
  belongs_to :user

  validates_presence_of :shift_id, :user_id
end
