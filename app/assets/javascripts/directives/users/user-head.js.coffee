@digiquatics.directive 'dqUserHead', [
  ->
    restrict: 'A' # this is default
    templateUrl: 'users/user-head.html'
    scope:
      text: '@dqUserHead'
      value: '@'
      order: '='

    link: (scope, element, attrs) ->
      element.bind 'click', ->
        if scope.order.value is scope.value
          scope.order.reverse = !scope.order.reverse
        else
          scope.order.reverse = false

        scope.order.value = scope.value

        scope.$apply()
]
