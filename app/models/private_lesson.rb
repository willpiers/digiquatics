class PrivateLesson < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  scope :claimed_by, -> (user) { where(user_id: user.id) }
  scope :unclaimed,  -> { where(user_id: nil) }

  belongs_to :account
  belongs_to :user
  has_many :private_lesson_details

  has_attached_file :attachment,
        path: ':rails_root/public/system/:attachment/:id/:style/:filename',
        url: '/system/:attachment/:id/:style/:filename'

  validates_presence_of :first_name, :email, :last_name, :phone_number,
                        :parent_first_name, :parent_last_name, :sex, :age,
                        :instructor_gender, :notes, :day, :time, :ability_level

  comma do
    last_name 'Student Last'
    first_name 'Student First'
    age
    sex
    ability_level 'Level'
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
