class StaticPagesController < ApplicationController
  def dashboard
    Tracker.track(current_user.id, 'View Dashboard') unless Rails.env.test?
  end

  def about
  end

  def privacy
  end

  def tos
  end

  def landing
    if !Rails.env.test? && current_user
      Tracker.track(current_user.id, 'View Index')
    end

    render :index, layout: false
  end

  def chemical_record_stats
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @pool = params[:pool_id]
    @chemical_records = ChemicalRecord.where(pool_id: @pool, created_at: @start_date..@end_date)
  end

  def user_stats
    @users = User.joins(:account).same_account_as(current_user)
    @location  = Location.all
  end
end
