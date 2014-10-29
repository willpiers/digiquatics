@digiquatics.factory 'ScheduleHelper', [
  ->
    class ScheduleHelper
      moment.locale 'dq', week: dow: 1

      _days = [
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
      ]

      @days = []

      _days.forEach (dayName) =>
        dayIndex = (Number(moment().day(dayName).weekday()) + 1) % 7
        @days[dayIndex] = dayName

      console.log @days

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
