class StaticPagesController < ApplicationController
  METRICS = { 'Free Chlorine (PPM)' => 'free_chlorine_ppm',
              'Combined Chlorine (PPM)' => 'combined_chlorine_ppm',
              'Total Chlorine (PPM)' => 'total_chlorine_ppm',
              'PH' => 'ph',
              'Alkalinity' => 'alkalinity',
              'Calcium Hardness' => 'calcium_hardness',
              'Air Temp (F)' => 'air_temp',
              'Pool Temp (F)' => 'pool_temp',
              'SI Index' => 'si_index' }

  def dashboard
    Tracker.track(current_user.id, 'View Dashboard') unless Rails.env.test?
  end

  def about
  end

  def privacy
  end

  def tos
  end

  def instructions
  end

  def availability
  end

  def landing
    render :index, layout: false
  end

  def chemical_record_stats
    Tracker.track(current_user.id, 'View Chemical Record Stats') unless Rails.env.test?
    @metrics = METRICS
    @start_date = params[:start_date]
    if @start_date
      @start_adj = DateTime.strptime(@start_date, '%Y-%m-%d %H:%M:%S').in_time_zone(Time.zone) + 6.hours
    end
    @end_date = params[:end_date]
    if @end_date
      @end_adj = DateTime.strptime(@end_date, '%Y-%m-%d %H:%M:%S').in_time_zone(Time.zone) + 6.hours
    end
    @pool_id = params[:pool_id]
    @facade = StaticPagesFacade.new(current_user)
    @free_cl = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :free_chlorine_ppm)
    @combined_cl = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :combined_chlorine_ppm)
    @total_cl = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :total_chlorine_ppm)
    @ph = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :ph)
    @ch = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :calcium_hardness)
    @alk = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :alkalinity)
    @air_temp = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :air_temp)
    @pool_temp = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :pool_temp)
    @si = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at desc').pluck(:id, :si_index)
  end

  def user_stats
    @facade = StaticPagesFacade.new(current_user)
  end

  def private_lesson_stats
    @facade = StaticPagesFacade.new(current_user)
  end
end
