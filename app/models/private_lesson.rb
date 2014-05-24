class PrivateLesson < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'
  ATTACHED_URL  = '/system/:attachment/:id/:style/:filename'

  scope :claimed_by, -> (user) { where(user_id: user.id) }
  scope :claimed,    -> { where.not(user_id: nil) }
  scope :unclaimed,  -> { where(user_id: nil) }
  scope :for_location, -> (location) { where(location_id: location.id) }

  belongs_to :account
  belongs_to :user
  has_many :participants
  belongs_to :location

  accepts_nested_attributes_for :participants, allow_destroy: true

  validates_presence_of :account_id, :parent_first_name, :parent_last_name,
                        :phone_number, :email, :contact_method,
                        :number_lessons

  comma do
    last_name 'Student Last'
    first_name 'Student First'
    age
    sex
    parent_last_name 'Parent Last'
    parent_first_name 'Parent First'
    phone_number 'Phone#'
    email
    contact_method 'Preferred Contact'
    instructor_gender 'Instructor Gender'
    notes 'Requests'
    day
    time
    preferred_location 'Location'
    created_at
    updated_at
  end
end
