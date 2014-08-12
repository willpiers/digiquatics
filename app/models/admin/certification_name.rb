class CertificationName < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  validates :account_id, presence: true
  validates :name, presence: true
  belongs_to :account
  has_many :certifications, dependent: :destroy
end
