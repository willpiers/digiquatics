@digiquatics.factory 'ScheduleHelper', [
  ->
    class ScheduleHelper
      @days = [
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
      ]

      @daysFromToday = 0

      @timeFormat: (time) ->
        moment(time).format 'h:mmA'

      @startEndTimes = (object) =>
        start = @timeFormat(object.start_time)
        end = @timeFormat(object.end_time)
        return "#{start}-#{end}"

      @weekDay = (days) =>
        moment().startOf('week').add 'days', @daysFromToday + days
]
