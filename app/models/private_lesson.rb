class PrivateLesson < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'
  ATTACHED_URL  = '/system/:attachment/:id/:style/:filename'

  scope :claimed_by, -> (user) { where(user_id: user.id) }
  scope :unclaimed,  -> { where(user_id: nil) }

  belongs_to :account
  belongs_to :user
  has_many :private_lesson_details

  has_attached_file :attachment,
                    path: ATTACHED_PATH,
                    url:  ATTACHED_URL

  validates_presence_of :parent_first_name, :parent_last_name, :phone_number,
                        :email, :contact_method, :first_name, :last_name,
                        :sex, :age, :instructor_gender, :notes, :number_lessons

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
