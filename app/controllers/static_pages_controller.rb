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
    Tracker.track(current_user.id, 'View Dashboard')
  end

  def privacy
  end

  def tos
  end

  def availability
  end

  def landing
    render :index, layout: false
  end

  def signup
    render :signup, layout: false
  end

  def team
    render :team, layout: false
  end

  def chemical_record_stats
    Tracker.track(current_user.id, 'View Chemical Record Stats')
    date_picker
    chemical_stats_table
    chemical_graphs
  end

  def user_stats
    @facade = StaticPagesFacade.new(current_user)
    employee_stat_graphs
  end

  def private_lesson_stats
    @facade = StaticPagesFacade.new(current_user)
    private_lessons_count_graph
  end

  private

  def private_lessons_count_graph
    @private_lessons_graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Unclaimed',
               data: unclaimed)
      f.series(name: 'Claimed',
               data: claimed)
      f.title({text: 'Total Private Lessons'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def private_lessons
    PrivateLesson.same_account_as(current_user)
  end

  def unclaimed
     @query = []
    location_query.each do |location|
      @query.push(private_lessons.for_location(location).unclaimed.count)
    end
    @query
  end

  def claimed
    @query = []
    location_query.each do |location|
      @query.push(private_lessons.for_location(location).claimed.count)
    end
    @query
  end

  def chemical_graphs
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
    data = ChemicalRecord.where(pool_id: @pool_id, created_at: @start_adj..@end_adj).order('created_at asc').map { |x| [x.created_at.strftime('%-m/%-d/%Y @ %I:%M%p'), x.calcium_hardness.to_f] }
    data.compact
    @ch = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({text: 'Calcium Hardness Levels'})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Calcium Hardness',
               data: data,
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

  def location_query
    Location.same_account_as(current_user)
  end

  def user_query
    User.same_account_as(current_user)
  end

  def males
     @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).female.count)
    end
    @query
  end

  def females
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).female.count)
    end
    @query
  end

  def admin
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).admin.count)
    end
    @query
  end

  def non_admin
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).non_admin.count)
    end
    @query
  end

  def active
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).active.count)
    end
    @query
  end

  def inactive
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).inactive.count)
    end
    @query
  end

  def shirt_size(size)
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).where(shirt_size: size).count)
    end
    @query
  end

  def male_suit(size)
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).male.where(suit_size: size).count)
    end
    @query
  end

  def one_piece(size)
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).female.where(femalesuit: size).count)
    end
    @query
  end

  def female_top(size)
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).female.where(shirt_size: size).count)
    end
    @query
  end

  def female_bottom(size)
    @query = []
    location_query.each do |location|
      @query.push(user_query.for_location(location).female.where(suit_size: size).count)
    end
    @query
  end

  def employee_stat_graphs
    employee_demographics
    employee_admin
    employee_status
    employee_shirts
    male_suits
    one_pieces
    female_tops
    female_bottoms
  end

  def employee_demographics
    @employee_demographics = LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Male',
               data: males,
               color: '#738FFE')
      f.series(name: 'Female',
               data: females,
               color: '#EC407A')
      f.title({text: 'Employee Demographics'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def employee_admin
    @employee_admin= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Admin',
               data: admin,
               color: '#2BAF2B')
      f.series(name: 'Non-Admin',
               data: non_admin,
               color: '#BDBDBD')
      f.title({text: 'Employee Classification'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def employee_status
    @employee_status= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Active',
               data: active,
               color: '#1DE9B6')
      f.series(name: 'Inactive',
               data: inactive,
               color: '#E84E40')
      f.title({text: 'Employee Status'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def employee_shirts
    @employee_shirts= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'XS',
               data: shirt_size('XS'),
               color: '#FFCCBC')
      f.series(name: 'S',
               data: shirt_size('S'),
               color: '#FF8A65')
      f.series(name: 'M',
               data: shirt_size('M'),
               color: '#FF5722')
      f.series(name: 'L',
               data: shirt_size('L'),
               color: '#E64A19')
      f.series(name: 'XL',
               data: shirt_size('XL'),
               color: '#BF360C')
      f.title({text: 'Employee Shirt Sizes'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def male_suits
    @male_suits= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'XS',
               data: male_suit('XS'),
               color: '#B3E5FC')
      f.series(name: 'S',
               data: male_suit('S'),
               color: '#4FC3F7')
      f.series(name: 'M',
               data: male_suit('M'),
               color: '#03A9F4')
      f.series(name: 'L',
               data: male_suit('L'),
               color: '#0288D1')
      f.series(name: 'XL',
               data: male_suit('XL'),
               color: '#01579B')
      f.title({text: 'Male Suit Sizes'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def one_pieces
    @one_pieces= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'Size(28)',
               data: one_piece('28'))
      f.series(name: 'Size(30)',
               data: one_piece('30'))
      f.series(name: 'Size(32)',
               data: one_piece('32'))
      f.series(name: 'Size(34)',
               data: one_piece('34'))
      f.series(name: 'Size(36)',
               data: one_piece('36'))
      f.series(name: 'Size(38)',
               data: one_piece('38'))
      f.series(name: 'Size(40)',
               data: one_piece('40'))
      f.title({text: 'Female One-Piece Suit Sizes'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def female_tops
    @female_tops= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'XS',
               data: female_top('XS'),
               color: '#F8BBD0')
      f.series(name: 'S',
               data: female_top('S'),
               color: '#F06292')
      f.series(name: 'M',
               data: female_top('M'),
               color: '#E91E63')
      f.series(name: 'L',
               data: female_top('L'),
               color: '#C2185B')
      f.series(name: 'XL',
               data: female_top('XL'),
               color: '#880E4F')
      f.title({text: 'Female Tops Sizes'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

  def female_bottoms
    @female_bottoms= LazyHighCharts::HighChart.new('graph') do |f|
      f.legend({layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0})
      f.series(name: 'XS',
               data: female_bottom('XS'),
               color: '#E1BEE7')
      f.series(name: 'S',
               data: female_bottom('S'),
               color: '#BA68C8')
      f.series(name: 'M',
               data: female_bottom('M'),
               color: '#9C27B0')
      f.series(name: 'L',
               data: female_bottom('L'),
               color: '#7B1FA2')
      f.series(name: 'XL',
               data: female_bottom('XL'),
               color: '#4A148C')
      f.title({text: 'Female Bottom Sizes'})
      f.options[:xAxis] = {plot_bands: 'none',
                           title: {text: 'Location'},
                           categories: Location.where(account_id: current_user.account_id).map { |x| x.name }}
      f.options[:chart][:defaultSeriesType] = 'bar'
      f.plot_options({bar: {stacking: 'normal'}})
    end
  end

end
