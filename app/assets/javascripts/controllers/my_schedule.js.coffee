@digiquatics.controller 'MyScheduleCtrl', ['$scope', 'MyShifts', 'Users',
                                           'Locations', 'Positions',
  @MyScheduleCtrl = ($scope, MyShifts, Users, Locations, Positions) ->
    # Services
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.weekCounter = 0

    $scope.previousWeek = ->
      $scope.weekCounter -= 7

    $scope.nextWeek = ->
      $scope.weekCounter += 7

    $scope.resetWeekCounter = ->
      $scope.weekCounter = 0

    $scope.displayStartDate = ->
      moment().startOf('week').add('days', $scope.weekCounter).format('MMM D')

    $scope.displayEndDate = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days).format('MMM D, YYYY')

    $scope.weekDay = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days)

    # show shifts by day of week
    $scope.sameDay = (shift, day) ->
      moment(shift).isSame($scope.weekDay(day), 'day')

    # Show Time off request over multiple days
    $scope.sameDayTimeOff = (start, end, day) ->
      moment(start).isSame($scope.weekDay(day), 'day') ||
      moment($scope.weekDay(day)).isAfter(start) &&
      moment($scope.weekDay(day)).isBefore(end)
]

