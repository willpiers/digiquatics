class StaticPagesController < ApplicationController
  METRICS = {'Free Chlorine (PPM)' => 'free_chlorine_ppm',
              'Combined Chlorine (PPM)' => 'combined_chlorine_ppm',
              'Total Chlorine (PPM)' => 'total_chlorine_ppm',
              'PH' => 'ph',
              'Alkalinity' => 'alkalinity',
              'Calcium Hardness' => 'calcium_hardness',
              'Air Temp (F)' => 'air_temp',
              'Pool Temp (F)' => 'pool_temp',
              'SI Index' => 'si_index'}

  def dashboard
    # Tracker.track(current_user.id, 'View Dashboard') unless Rails.env.test?
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
    @metrics = METRICS
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @pool_id = params[:pool_id]
    @facade = StaticPagesFacade.new(current_user)
  end

  def user_stats
    @facade = StaticPagesFacade.new(current_user)
  end

  def private_lesson_stats
    @facade = StaticPagesFacade.new(current_user)
  end
end

