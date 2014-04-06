class StaticPagesController < ApplicationController
  def dashboard
    Tracker.track(current_user.id, 'View Dashboard') unless Rails.env.test?
  end

  def about
  end

  def index
    if !Rails.env.test? && current_user
      Tracker.track(current_user.id, 'View Index')
    end

    render :index, layout: false
  end

  def chemical_record_stats
    @chemical_records = ChemicalRecord.all
  end

  def user_stats
    @users = User.joins(:account).same_account_as(current_user)
    @location  = Location.all
  end
end
