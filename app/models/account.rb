class Account < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'
  ATTACHED_URL  = '/system/:attachment/:id/:style/:filename'

  validates_presence_of  :name
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

  has_attached_file :logo,
                    path: ATTACHED_PATH,
                    url:  ATTACHED_URL

  accepts_nested_attributes_for :users
end
