class ShiftReport < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'

  belongs_to :account
  belongs_to :location
  belongs_to :user

  has_attached_file :attachment_front,
                    path: ATTACHED_PATH,
                    url: '/system/:attachment/:id/:style/:filename'

  has_attached_file :attachment_back,
                    path: ATTACHED_PATH,
                    url: '/system/:attachment/:id/:style/:filename'

  validates_presence_of :content, :user_id, :location_id

  comma do
    content
    user_id
    location_id
  end
end
