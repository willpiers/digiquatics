class Account < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  validates_inclusion_of :time_zone,
                         in: ActiveSupport::TimeZone.zones_map(&:name)

  has_many :certification_names
  has_many :users
  has_many :certifications, through: :certification_names
  has_many :locations
  has_many :positions
  has_many :private_lessons
  has_many :shift_reports
  has_many :help_desks
end
