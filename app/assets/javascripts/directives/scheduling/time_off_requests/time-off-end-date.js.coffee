@digiquatics.directive 'dqTimeOffEndDate', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/time-off/time-off-end-date.html'
    scope:
      request: '='
      data: '='

    link: (scope, element, attrs) ->
      scope.open2 = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()
        scope.opened2 = true

      scope.format = 'yyyy-MM-dd'

      scope.dateOptions =
        "year-format": "'yy'"
        "starting-day": 1

      scope.hstep = 1

      scope.ismeridian = true
]
