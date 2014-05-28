module ScopeHelper
  def include_scopes
    scope :same_account_as, -> (user) { where(account_id: user.account_id) }
  end

  def include_user_scopes
    scope :active,          ->        { where(active: true) }
    scope :inactive,        ->        { where(active: false) }

    scope :male,            ->        { where(sex: 'M') }
    scope :female,          ->        { where(sex: 'F') }

    scope :admin,           ->        { where(admin: true) }

    scope :for_location, -> (location) { where(location_id: location.id) }
  end
end
