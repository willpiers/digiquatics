class ShiftReport < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  belongs_to :location
  has_many  :users

  has_attached_file :attachment_front,
                    path: ':rails_root/public/system/:attachment/:id/:style/:filename',
                    url: '/system/:attachment/:id/:style/:filename'

  has_attached_file :attachment_back,
                    path: ':rails_root/public/system/:attachment/:id/:style/:filename',
                    url: '/system/:attachment/:id/:style/:filename'

  accepts_nested_attributes_for :users

  comma do
    post_title
    post_content
    user_id
    location_id
    time_stamp
    date_stamp
  end
end

