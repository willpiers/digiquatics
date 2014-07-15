class SubRequest < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :shift

  validates_presence_of :shift_id
end
