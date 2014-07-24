@digiquatics.controller 'ShiftsCtrl', ['$scope', '$filter', 'Shifts', 'Users',
                                       'Locations', 'Positions',
  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions) ->
    # Services
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Weeks

    $scope.buildMode = 'Build'

    $scope.build = ->
      $scope.buildMode == 'Build'

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

    $scope.weekStart = ->
      moment().startOf('week').add('days', $scope.weekCounter)

    $scope.addToWeek = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days)

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

    # show shifts by day of week

    $scope.sunday = (shift) ->
      moment(shift).isSame($scope.weekStart(), 'day')

    $scope.monday = (shift) ->
      moment(shift).isSame($scope.addToWeek(1), 'day')

    $scope.tuesday = (shift) ->
      moment(shift).isSame($scope.addToWeek(2), 'day')

    $scope.wednesday = (shift) ->
      moment(shift).isSame($scope.addToWeek(3), 'day')

    $scope.thursday = (shift) ->
      moment(shift).isSame($scope.addToWeek(4), 'day')

    $scope.friday = (shift) ->
      moment(shift).isSame($scope.addToWeek(5), 'day')

    $scope.saturday = (shift) ->
      moment(shift).isSame($scope.addToWeek(6), 'day')

    # Show Time off request over multiple days
    $scope.sundayTime = (start, end) ->
      moment(start).isSame($scope.weekStart(), 'day') ||
      moment($scope.weekStart()).isAfter(start) &&
      moment($scope.weekStart()).isBefore(end)

    $scope.mondayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(1), 'day') ||
      moment($scope.addToWeek(1)).isAfter(start) &&
      moment($scope.addToWeek(1)).isBefore(end)

    $scope.tuesdayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(2), 'day') ||
      moment($scope.addToWeek(2)).isAfter(start) &&
      moment($scope.addToWeek(2)).isBefore(end)

    $scope.wednesdayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(3), 'day') ||
      moment($scope.addToWeek(3)).isAfter(start) &&
      moment($scope.addToWeek(3)).isBefore(end)

    $scope.thursdayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(4), 'day') ||
      moment($scope.addToWeek(4)).isAfter(start) &&
      moment($scope.addToWeek(4)).isBefore(end)

    $scope.fridayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(5), 'day') ||
      moment($scope.addToWeek(5)).isAfter(start) &&
      moment($scope.addToWeek(5)).isBefore(end)

    $scope.saturdayTime = (start, end) ->
      moment(start).isSame($scope.addToWeek(6), 'day') ||
      moment($scope.addToWeek(6)).isAfter(start) &&
      moment($scope.addToWeek(6)).isBefore(end)
]

