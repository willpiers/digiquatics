class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  around_filter :account_time_zone, if: :current_user

  private

  def account_time_zone(&block)
    Time.use_zone(current_user.account.time_zone, &block)
  end
end
