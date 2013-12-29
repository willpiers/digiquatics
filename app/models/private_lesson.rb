class PrivateLesson < ActiveRecord::Base

	belongs_to  :account

	validates_presence_of :first_name, :email, :last_name, :phone_number, :parent_first_name,
    :parent_last_name, :sex, :age, :instructor_gender, :notes, :day, :time, :ability_level

end
