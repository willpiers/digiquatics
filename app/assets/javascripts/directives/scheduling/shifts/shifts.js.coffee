@digiquatics.directive 'dqShifts', [
  'ScheduleHelper'

  (ScheduleHelper) ->
    restrict: 'E'
    templateUrl: 'scheduling/shifts.html'
    scope:
      user: '='
      dayName: '='
      shifts: '='

    link: (scope, element, attrs) ->
      scope.days = ScheduleHelper.days

      scope.startEndTimes = ScheduleHelper.startEndTimes

]
