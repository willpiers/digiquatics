class Certification < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification_name
end
