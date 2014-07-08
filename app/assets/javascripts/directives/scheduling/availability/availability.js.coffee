@digiquatics.directive 'dqAvailability', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/availability/availability.html'
    scope: {}

    link: (scope, element, attrs) ->
      scope.days = [
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
      ]

      element.bind 'submit', ->
        scope.$broadcast 'submit-availabilities'
]
