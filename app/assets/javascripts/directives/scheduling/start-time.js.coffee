@digiquatics.directive 'dqStartTime', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/start-time.html'
    scope:
      request: '='
      data: '='

    link: (scope, element, attrs) ->
      if scope.request
        scope.data.start = scope.request.starts_at

]
