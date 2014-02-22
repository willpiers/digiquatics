class PreventativeList < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :name
end
