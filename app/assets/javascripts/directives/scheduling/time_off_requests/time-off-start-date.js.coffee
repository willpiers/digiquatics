@digiquatics.directive 'dqTimeOffStartDate', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/time-off/time-off-start-date.html'
    scope:
      request: '='
      data: '='

    link: (scope, element, attrs) ->
      scope.open1 = ($event) ->
        $event.preventDefault()
        $event.stopPropagation()
        scope.opened1 = true

      scope.format = 'yyyy-MM-dd'

      scope.dateOptions =
        "year-format": "'yy'"
        "starting-day": 1

      scope.hstep = 1

      scope.ismeridian = true
]
