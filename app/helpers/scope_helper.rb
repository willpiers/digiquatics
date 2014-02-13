module ScopeHelper
  def include_scopes
    scope :same_account_as, -> (user) { where(account_id: user.account_id) }
    scope :inactive, -> (user) { where(active: false) }
  end
end
