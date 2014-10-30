@digiquatics.factory 'ScheduleHelper', [
  ->
    class ScheduleHelper
      moment.locale 'dq', week: dow: 1

      @days = [
        moment().weekday(0).format 'dddd'
        moment().weekday(1).format 'dddd'
        moment().weekday(2).format 'dddd'
        moment().weekday(3).format 'dddd'
        moment().weekday(4).format 'dddd'
        moment().weekday(5).format 'dddd'
        moment().weekday(6).format 'dddd'
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
