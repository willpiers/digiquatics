class PrivateLesson < ActiveRecord::Base
  scope :claimed_by, -> (user) { where(user_id: user.id) }
  scope :unclaimed,  -> { where(user_id: nil) }

  belongs_to :account
  belongs_to :user

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
