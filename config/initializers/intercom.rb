IntercomRails.config do |config|
  # == Intercom app_id
  config.app_id = ENV['INTERCOM_APP_ID'] ||
    'd41562edd070e34d1f970f80381798645196bfc3'

  # == Intercom secret key
  # This is required to enable secure mode, you can find it on your Intercom
  # 'security' configuration page.

  config.api_secret = 'ztoqApG4JC4f40DRX0YZhVN64wFfYF8frozMAG_-'

  # == Intercom API Key
  # This is required for some Intercom rake tasks like importing your users;
  # you can generate one at https://www.intercom.io/apps/api_keys.
  #
  # config.api_key = '...'

  # == Enabled Environments
  # Which environments is auto inclusion of the Javascript enabled for

  config.enabled_environments = %w('development', 'production')

  # == Current user method/variable
  # The method/variable that contains the logged in user in your controllers.
  # If it is `current_user` or `@user`, then you can ignore this
  #
  # config.user.current = Proc.new { current_user }

  # == User model class
  # The class which defines your user model
  #
  # config.user.model = Proc.new { User }

  # == User Custom Data
  # A hash of additional data you wish to send about your users.
  # You can provide either a method name which will be sent to the current
  # user object, or a Proc which will be passed the current user.

  config.user.custom_data = {
    first_name:    proc { |current_user| current_user.first_name },
    last_name:     proc { |current_user| current_user.last_name },
    phone_number:  proc { |current_user| current_user.phone_number }
  }

  # == User -> Company association
  # A Proc that given a user returns an array of companies
  # that the user belongs to.
  #
  # config.user.company_association = proc { |user| user.companies.to_a }
  # config.user.company_association = proc { |user| [user.company] }

  # == Current company method/variable
  # The method/variable that contains the current company for the current user,
  # in your controllers. 'Companies' are generic groupings of users, so this
  # could be a company, app or group.

  config.company.current = proc { current_account }

  # == Company Custom Data
  # A hash of additional data you wish to send about a company.
  # This works the same as User custom data above.

  config.company.custom_data = {
    name: proc { |current_account| current_account.name }
  }

  # == Company Plan name
  # This is the name of the plan a company is currently paying (or not paying)
  # for.
  # e.g. Messaging, Free, Pro, etc.
  #
  # config.company.plan =
  #   proc { |current_company| current_company.plan.name }

  # == Company Monthly Spend
  # This is the amount the company spends each month on your app. If your
  # company has a plan, it will set the 'total value' of that plan
  # appropriately.
  #
  # config.company.monthly_spend =
  #   Proc.new { |current_company| current_company.plan.price }
  # config.company.monthly_spend =
  #   Proc.new do |current_company|
  #     (current_company.plan.price - current_company.subscription.discount)
  #   end

  # == Inbox Style
  # This enables the Intercom inbox which allows your users to read their
  # past conversations with your app, as well as start new ones. It is
  # disabled by default.
  #   * :default shows a small tab with a question mark icon on it
  #   * :custom attaches the inbox open event to an anchor with an
  #             id of #Intercom.
  #
  # config.inbox.style = :default
  # config.inbox.style = :custom
end
