class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, except: [:new, :create, :landing,
                                              :thank_you, :tos, :privacy,
                                              :team, :signup]
  include SessionsHelper

  around_filter :account_time_zone, if: :current_user

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  private

  def account_time_zone(&block)
    Time.use_zone(current_user.account.time_zone, &block)
  end
end
