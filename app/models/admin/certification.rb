class Certification < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  ATTACHED_PATH = ':rails_root/public/system/:attachment/:id/:style/:filename'
  ATTACHED_URL  = '/system/:attachment/:id/:style/:filename'

  belongs_to :user
  belongs_to :certification_name
  belongs_to :account

  has_attached_file :attachment,
                    path: ATTACHED_PATH,
                    url: ATTACHED_URL

  validates_presence_of :certification_name_id, :expiration_date, :user_id

  after_save :track

  comma do
    location name: 'Location'
    certification_name :name
    issue_date
    expiration_date
  end

  private

  def track
    Tracker.track(nil, 'Create New Certification',
                  certification_name_id: certification_name_id,
                  user_id: user_id)
  end
end
