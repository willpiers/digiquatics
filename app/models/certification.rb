class Certification < ActiveRecord::Base
  scope :account, -> { where(account_id: current_user.account.id) }

  belongs_to :user
  belongs_to :certification_name
  belongs_to :account
  has_attached_file :attachment,
        :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
        :url => "/system/:attachment/:id/:style/:filename"
        
  validates :certification_name_id, presence: true
  validates :user_id, presence: true
  validates :expiration_date, presence: true

  # ===============
  # = CSV support =
  # ===============
  comma do  # implicitly named :default
    user :last_name => 'Last'
    user :first_name => 'First'
    user :employee_id => 'ID'
    user :phone_number => 'Phone#'
    user :email

    certification_name :name

    certification_name.attributes.each {|attr_name, attr_value|}


    issue_date
    expiration_date
  end

end
