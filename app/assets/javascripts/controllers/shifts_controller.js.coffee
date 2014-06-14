@digiquatics.controller 'ShiftsCtrl', ['$scope', 'Shifts', 'Users',
                                       'Locations', 'Positions',
  @UsersCtrl = ($scope, Shifts, Users, Locations, Positions) ->
    $scope.shifts = Shifts.index()
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
      moment().startOf('week').add('days', $scope.weekCounter).format('MMM D');

    $scope.displayEndDate = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days).format('MMM D, YYYY');

    $scope.weekStart = ->
      moment().startOf('week').add('days', $scope.weekCounter).format('ddd, MMM D');
    $scope.addToWeek = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days).format('ddd, MMM D');

    $scope.predicate =
      value: 'last_name'
]
