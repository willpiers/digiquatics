module ScopeHelper
  def include_scopes
    scope :same_account_as, -> (user) { where(account_id: user.account_id) }

  end

  def pool_scopes
    scope :same_location_as, -> (user) { where(location_id: user.location_id) }
  end
end
