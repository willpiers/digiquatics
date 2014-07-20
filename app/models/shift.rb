class Shift < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :user
  belongs_to :position
  belongs_to :location
  has_many :sub_requests

  validates_presence_of :user_id, :position_id, :location_id, :start_time,
                        :end_time

end
