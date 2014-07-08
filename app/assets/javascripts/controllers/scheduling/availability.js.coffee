@digiquatics.controller 'AvailabilityCtrl', [
  '$scope'

  @AvailabilityCtrl = ($scope) ->
    $scope.days = [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]
]
