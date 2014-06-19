@digiquatics.controller 'ShiftsCtrl', ['$scope', 'Shifts', 'Users',
                                       'Locations', 'Positions',
  @UsersCtrl = ($scope, Shifts, Users, Locations, Positions) ->
    # Services
    $scope.shifts = Shifts.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Weeks
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

    # Days
    $scope.dayCounter = 0

    $scope.previousDay = ->
      $scope.dayCounter -= 1

    $scope.nextDay = ->
      $scope.dayCounter += 1

    $scope.resetDayCounter = ->
      $scope.dayCounter = 0

    $scope.today = ->
      moment().format('MMM D, YYYY')

    $scope.displayDay = ->
      moment().add('days', $scope.dayCounter).format('dddd, MMM D YYYY')

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.ifValue = true

    $scope.showIf = ->
      $scope.ifValue

    $scope.hideIf = ->
      not $scope.ifValue
]
