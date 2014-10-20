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

      @timeFormat: (time) ->
        moment(time).format 'h:mmA'

      @startEndTimes = (object) =>
        start = @timeFormat(object.start_time)
        end = @timeFormat(object.end_time)
        return "#{start}-#{end}"
]
