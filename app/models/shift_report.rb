class ShiftReport < ActiveRecord::Base
  extend ScopeHelper
  include_scopes

  belongs_to :account
  belongs_to :location
  has_many  :users

  accepts_nested_attributes_for :users

end
