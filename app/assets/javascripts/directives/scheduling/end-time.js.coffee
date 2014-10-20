@digiquatics.directive 'dqEndTime', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/end-time.html'
    scope:
      request: '='
      data: '='

    link: (scope, element, attrs) ->
      if scope.request
        scope.data.end = scope.request.ends_at
]
