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
    user last_name: 'Last'
    user first_name: 'First'
    user employee_id: 'ID'
    user phone_number: 'Phone#'
    user :email
    certification_name :name
    issue_date
    expiration_date
  end

  private

  def track
    Tracker.track(nil, 'Create New Certification',
                  certification_name: certification_name.name,
                  user_id: user_id) unless Rails.env.test?
  end
end
