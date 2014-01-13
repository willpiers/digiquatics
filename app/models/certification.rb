class Certification < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :user
  belongs_to :certification_name
  belongs_to :account
  has_attached_file :attachment,
        path: ':rails_root/public/system/:attachment/:id/:style/:filename',
        url: '/system/:attachment/:id/:style/:filename'

  validates_presence_of :certification_name_id, :expiration_date, :account_id,
                        :user_id

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
end
