class Participant < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :private_lesson
  belongs_to :skill_level

  validates_presence_of :first_name, :sex, :age
end
