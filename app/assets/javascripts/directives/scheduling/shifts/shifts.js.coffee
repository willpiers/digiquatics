@digiquatics.directive 'dqShifts', [
  'ScheduleHelper'

  (ScheduleHelper, $timeout) ->
    restrict: 'E'
    templateUrl: 'scheduling/shifts.html'
    scope:
      dayName: '='
      shifts: '='
      userIsAdmin: '='
      open: '&'

    link: (scope, element, attrs) ->
      scope.days = ScheduleHelper.days
      scope.startEndTimes = ScheduleHelper.startEndTimes
]
