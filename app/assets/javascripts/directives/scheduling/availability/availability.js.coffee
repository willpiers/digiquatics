@digiquatics.directive 'dqAvailability', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/availability/availability.html'
    scope:
      days: '='

    link: (scope, element, attrs) ->
      element.bind 'submit', ->
        scope.$broadcast 'submit-availabilities'
]
