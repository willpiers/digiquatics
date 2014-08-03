@digiquatics.directive 'dqAvailabilityTime', [
  'AvailabilityService'

  (Availability) ->
    restrict: 'E'
    templateUrl: 'scheduling/availability/availability-time.html'
    scope:
      day: '='

    link: (scope, element, attrs) ->
      scope.$on 'submit-availabilities', =>
        if scope.start and scope.end
          Availability.create
            start_time: scope.start
            end_time: scope.end
            day: scope.day
]
