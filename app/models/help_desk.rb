class HelpDesk < ActiveRecord::Base

belongs_to :account
has_many :users
belongs_to :location

has_attached_file :help_desk_attachment,
      path: ':rails_root/public/system/:attachment/:id/:style/:filename',
      url: '/system/:attachment/:id/:style/:filename'

end
