@digiquatics.directive 'dqTimeOffRequests', [
  'ScheduleHelper'

  (ScheduleHelper) ->
    restrict: 'E'
    templateUrl: 'scheduling/time-off-requests.html'
    scope:
      dayName: '='
      timeOffRequests: '='

    link: (scope, element, attrs) ->
      scope.timeOffRequestTimes = (timeOffRequest) ->
        if timeOffRequest.all_day
          'Time Off'
        else
          start = ScheduleHelper.timeFormat timeOffRequest.starts_at
          end = ScheduleHelper.timeFormat timeOffRequest.ends_at
          "#{start}-#{end}"

      scope.timeOffRequestFilter = (day) ->
        (timeOffRequest) ->
          dayIndex = ScheduleHelper.days.indexOf day

          timeOffRequest.dayIndices.length and
            dayIndex in timeOffRequest.dayIndices

]
