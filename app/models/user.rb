class User < ActiveRecord::Base
  include PaperclipHelper
  extend ScopeHelper
  include_scopes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  belongs_to  :account
  has_many    :certifications
  has_many    :private_lessons
  has_many    :shift_reports
  belongs_to  :location
  belongs_to  :position
  has_many    :help_desks

  has_attached_file :avatar,
                    path: PAPERCLIP_PATH,
                    url: '/system/:attachment/:id/:style/:filename',
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    default_url: '/images/missing.png'

  accepts_nested_attributes_for :certifications,
                                reject_if: proc { |a| a[:attachment].blank? }

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_presence_of :account_id

  has_secure_password
  validates_length_of :password, minimum: 6

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(search)
    if search where('first_name LIKE ? OR last_name LIKE ? ',
                    "%#{search}%", "%#{search}%")
    else
      User.all
    end
  end

  comma do
    last_name 'Last'
    first_name 'First'
    date_of_birth 'DOB'
    sex
    employee_id 'ID'
    date_of_hire 'DOH'
    location name: 'Location'
    position name: 'Position'
    email
    phone_number 'Phone#'
    suit_size
    shirt_size
    femalesuit
    admin
    active
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
