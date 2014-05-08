@digiquatics.directive 'dqHi', [
  ->
    restrict: 'E'
    templateUrl: 'hi.html'
    link: (scope, element, attrs) ->
      console.log 'hi'
]
