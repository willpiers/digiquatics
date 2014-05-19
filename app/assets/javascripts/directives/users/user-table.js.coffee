@digiquatics.directive 'dqUserTable', [
  ->
    restrict: 'E'
    templateUrl: 'user-table.html'

    link: (scope, element, attrs) ->
      scope.order =
        value: 'last_name'
        reverse: false
]
