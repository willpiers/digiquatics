class PreventativeList < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :name, :task_type
end
