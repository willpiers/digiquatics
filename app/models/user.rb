class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  belongs_to  :account
  has_many    :certifications
  has_many    :private_lessons
  belongs_to  :location
  belongs_to  :position

  accepts_nested_attributes_for :certifications, reject_if: lambda { |a| a[:attachment].blank? }

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:
    { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates_presence_of :shirt_size, :suit_size, :account_id, :location_id,
    :position_id
  has_secure_password
  validates_length_of :password, minimum: 6

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(search)
    if search
      where('first_name LIKE ? OR last_name LIKE ? ', "%#{search}%",
        "%#{search}%")
    else
      User.all
    end
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
