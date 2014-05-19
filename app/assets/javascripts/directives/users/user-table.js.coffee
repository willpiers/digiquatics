@digiquatics.directive 'dqUserTable', [
  ->
    restrict: 'E'
    templateUrl: 'users/user-table.html'

    link: (scope, element, attrs) ->
      scope.order =
        value: 'last_name'
        reverse: false
]
