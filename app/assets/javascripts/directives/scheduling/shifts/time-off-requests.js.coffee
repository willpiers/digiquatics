@digiquatics.directive 'dqTimeOffRequests', [
  'TimeOffHelper'

  (TimeOffHelper) ->
    restrict: 'E'
    templateUrl: 'scheduling/shifts/time-off-requests.html'
    scope:
      days: '='
      dayName: '='
      timeOffRequests: '='

    link: (scope, element, attrs) ->
      scope.timeOffRequestTimes = (timeOffRequest) ->
        if timeOffRequest.all_day
          'Time Off'
        else
          start = TimeOffHelper.timeFormat timeOffRequest.starts_at
          end = TimeOffHelper.timeFormat timeOffRequest.ends_at
          "#{start}-#{end}"

      scope.timeOffRequestFilter = (day) ->
        (timeOffRequest) ->
          dayIndex = scope.days.indexOf day

          timeOffRequest.dayIndices.length and
            dayIndex in timeOffRequest.dayIndices

]
