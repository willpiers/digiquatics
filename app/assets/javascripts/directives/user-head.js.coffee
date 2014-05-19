@digiquatics.directive 'dqUserHead', [
  ->
    restrict: 'A' # this is default
    templateUrl: 'user-head.html'
    scope:
      text: '@dqUserHead'
      value: '@'
      order: '='

    link: (scope, element, attrs) ->
      element.bind 'click', ->
        scope.order.value = scope.value
        scope.order.reverse = !scope.order.reverse

        scope.$apply()
]
