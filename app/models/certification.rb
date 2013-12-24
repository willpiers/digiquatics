class Certification < ActiveRecord::Base
  scope :account, -> { where(account_id: current_user.account.id) }

  belongs_to :user
  belongs_to :certification_name
  belongs_to :account
  has_attached_file :attachment

  validates :certification_name_id, presence: true
  validates :user_id, presence: true
  validates :expiration_date, presence: true
end
