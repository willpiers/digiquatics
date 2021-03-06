class Location < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  validates :account_id, presence: true
  validates :name, presence: true

  belongs_to :account

  has_many :chemical_records
  has_many :users
  has_many :shift_reports
  has_many :help_desks
  has_many :private_lessons
  has_many :pools, dependent: :destroy
  has_many :slides, dependent: :destroy
  has_many :shifts
  has_many :time_off_requests


  accepts_nested_attributes_for :pools,
                                reject_if: -> (pool) { pool[:name].blank? },
                                allow_destroy: true

  accepts_nested_attributes_for :slides,
                                reject_if: -> (slide) { slide[:name].blank? },
                                allow_destroy: true
end
