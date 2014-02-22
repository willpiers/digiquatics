class Location < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  validates :account_id, presence: true
  validates :name, presence: true

  belongs_to :account

  has_many :users
  has_many :shift_reports
  has_many :help_desks
  has_many :pools, dependent: :destroy

  accepts_nested_attributes_for :pools,
                                reject_if: -> (pool) { pool[:name].blank? },
                                allow_destroy: true
end
