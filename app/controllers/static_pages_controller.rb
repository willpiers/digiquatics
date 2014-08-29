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
    date_picker
    chemical_stats_table
    cheical_graphs
  end

  def user_stats
    @facade = StaticPagesFacade.new(current_user)
  end

  def private_lesson_stats
    @facade = StaticPagesFacade.new(current_user)
  end

  private

  def cheical_graphs
    temp
    ph
    cl
    alk
    ch
    si
  end

  def date_picker
    start_date
    end_date
    @pool_id = params[:pool_id]
  end

  def start_date
    @start_date = params[:start_date]
    if @start_date
      @start_adj = DateTime.strptime(@start_date, '%Y-%m-%d %H:%M:%S').in_time_zone(Time.zone) + 6.hours
    end
  end

  def end_date
    @end_date = params[:end_date]
    if @end_date
      @end_adj = DateTime.strptime(@end_date, '%Y-%m-%d %H:%M:%S').in_time_zone(Time.zone) + 6.hours
    end
  end

  def chemical_stats_table
    @metrics = METRICS
    @facade = StaticPagesFacade.new(current_user)
  end

  def cl
    @cl = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'Chlorine Levels'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Free',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.free_chlorine_ppm.to_f] },
               color: '#FFC107')
      f.series(name: 'Combined',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.combined_chlorine_ppm.to_f] },
               color: '#8BC34A')
      f.series(name: 'Total',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.total_chlorine_ppm.to_f] },
               color: '#259B24')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: 'Chlorine (ppm)',
                 margin: 10} }
      ]
    end
  end

  def temp
    @temp = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'Temperature Levels'})
      f.tooltip({valueSuffix: '°F'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Air',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.air_temp.to_f] },
               color: '#3F51B5')
      f.series(name: 'Pool',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.pool_temp.to_f] },
               color: '#5677FC')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: 'Temperature (°F)',
                 margin: 10} }
      ]
    end
  end

  def ph
    @ph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'PH Levels'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'PH',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.ph.to_f] },
               color: '#E84E40')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: '(pH)',
                 margin: 10} }
      ]
    end
  end

  def alk
    @alk = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'Alkalinity Levels'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Alkalinity',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.alkalinity.to_f] },
               color: '#009688')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: 'Alkalinity (ppm)',
                 margin: 10}}
      ]
    end
  end

  def ch
    @ch = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'Calcium Hardness Levels'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Calcium Hardness',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.calcium_hardness.to_f] },
               color: '#9C27B0')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: 'Calcium Hardness (PPM)',
                 margin: 10}}
      ]
    end
  end

  def si
    @si = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'SI Index'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'SI Index',
               data: ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.si_index.to_f] },
               color: '#FF5722')
      f.xAxis [
        {title: {text: 'Record',
                 margin: 10} }
      ]
      f.yAxis [
        {title: {text: 'SI Index',
                 margin: 10}}
      ]
    end
  end
end
