class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable

  include PaperclipHelper
  extend ScopeHelper
  include_scopes
  include_user_scopes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }

  belongs_to :account
  belongs_to :location
  belongs_to :position

  has_many :availabilities
  has_many :certifications
  accepts_nested_attributes_for :certifications, allow_destroy: true
  has_many :chemical_records
  has_many :help_desks
  has_many :private_lessons
  has_many :shift_reports
  has_many :shifts
  has_many :slide_inspections
  has_many :sub_requests
  has_many :time_off_requests

  has_attached_file :avatar,
                    path: PAPERCLIP_PATH,
                    url: '/system/:attachment/:id/:style/:filename',
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    default_url: '/images/missing.png'

  validates_presence_of :account_id
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name,  presence: true, length: { maximum: 25 }

  validates :password,
            confirmation: true,
            presence: true,
            length: { minimum: 6 },
            on: :create
  validates :password,
            confirmation: true,
            presence: true,
            length: { minimum: 6 },
            on: :update,
            allow_blank: true
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

  def full_name
    "#{first_name}[#{last_name}]"
  end

  comma do
    last_name 'Last Name'
    first_name 'First Name'
    phone_number 'Phone #'
    email 'Email'
    date_of_birth 'DOB'
    sex 'Sex'
    secondary_phone_number 'Other Phone #'
    address1 'Address 1'
    address2 'Address 2'
    city 'City'
    state 'State'
    zipcode 'Zip'
    suit_size 'Suit Size'
    shirt_size 'Shirt Size'
    femalesuit 'One Piece Size'
    emergency_first 'Emergency First Name'
    emergency_last 'Emergency Last Name'
    emergency_phone 'Emergency Phone #'
    location name: 'Location'
    position name: 'Position'
    grouping 'Group'
    employee_id 'ID'
    payrate 'Pay Rate'
    date_of_hire 'DOH'
    chemical_records_access 'Chemicals Access'
    private_lesson_access 'Lessons Access'
    admin 'Admin'
    active 'Active'
    notes 'Notes'
  end
end
