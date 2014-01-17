class HelpDesk < ActiveRecord::Base

belongs_to :account
has_many :users
belongs_to :location

end
