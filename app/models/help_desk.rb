class HelpDesk < ActiveRecord::Base
  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'

  belongs_to :account
  belongs_to :user
  belongs_to :location
  has_attached_file :help_desk_attachment,
                    path: ATTACHED_PATH,
                    url: '/system/:attachment/:id/:style/:filename'

  validates_presence_of :name, :urgency, :user_id, :location_id

  validates_attachment :help_desk_attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

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
