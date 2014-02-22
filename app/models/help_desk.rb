class HelpDesk < ActiveRecord::Base
  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'

  belongs_to :account
  has_many :users
  belongs_to :location
  has_attached_file :help_desk_attachment,
                    path: ATTACHED_PATH,
                    url: '/system/:attachment/:id/:style/:filename'

  comma do
    name
    urgency
    user_id
    location_id
    description
    issue_status
    created_at
    updated_at
  end
end
