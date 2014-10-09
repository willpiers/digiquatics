@digiquatics.directive 'dqAvailabilities', [
  'ScheduleHelper'

  (ScheduleHelper) ->
    restrict: 'E'
    templateUrl: 'scheduling/availabilities.html'
    scope:
      dayName: '='
      availabilities: '='

    link: (scope, element, attrs) ->
      scope.days = ScheduleHelper.days

      scope.startEndTimes = ScheduleHelper.startEndTimes
]
