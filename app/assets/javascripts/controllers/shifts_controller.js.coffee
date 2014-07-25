@digiquatics.controller 'ShiftsCtrl', ['$scope', '$filter', 'Shifts', 'Users',
                                       'Locations', 'Positions', '$modal'
  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions, $modal) ->
    # Services
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Weeks

    $scope.open = (size) ->
      modal = $modal.open(
        templateUrl: 'scheduling/shift-assigner.html',
        controller: ModalCtrl,
        size: size,
        resolve:
          startTime: ->
            $scope.startTime
          endTime: ->
            $scope.endTime
          positions: ->
            $scope.positions
        )

    ModalCtrl = ($scope, $modal, startTime, endTime, positions) ->
      $scope.startTime = startTime
      $scope.endTime = endTime
      $scope.positions = positions
      $scope.ok = ->
        $modal.close "Assign"
        return

      $scope.cancel = ->
        $modal.dismiss "Cancel"
        return

      return

    # $scope.setStart = (days) ->
    #   start = new Date()
    #   start.setUTCDate($scope.weekDay(days).format('DD'))
    #   start.setHours(7)
    #   start.setMinutes(0)
    #   $scope.startTime = start

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

    $scope.weekDay = (days) ->
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
      moment(shift).isSame($scope.weekDay(0), 'day')

    $scope.monday = (shift) ->
      moment(shift).isSame($scope.weekDay(1), 'day')

    $scope.tuesday = (shift) ->
      moment(shift).isSame($scope.weekDay(2), 'day')

    $scope.wednesday = (shift) ->
      moment(shift).isSame($scope.weekDay(3), 'day')

    $scope.thursday = (shift) ->
      moment(shift).isSame($scope.weekDay(4), 'day')

    $scope.friday = (shift) ->
      moment(shift).isSame($scope.weekDay(5), 'day')

    $scope.saturday = (shift) ->
      moment(shift).isSame($scope.weekDay(6), 'day')

    # Show Time off request over multiple days
    $scope.sundayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(0), 'day') ||
      moment($scope.weekDay(0)).isAfter(start) &&
      moment($scope.weekDay(0)).isBefore(end)

    $scope.mondayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(1), 'day') ||
      moment($scope.weekDay(1)).isAfter(start) &&
      moment($scope.weekDay(1)).isBefore(end)

    $scope.tuesdayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(2), 'day') ||
      moment($scope.weekDay(2)).isAfter(start) &&
      moment($scope.weekDay(2)).isBefore(end)

    $scope.wednesdayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(3), 'day') ||
      moment($scope.weekDay(3)).isAfter(start) &&
      moment($scope.weekDay(3)).isBefore(end)

    $scope.thursdayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(4), 'day') ||
      moment($scope.weekDay(4)).isAfter(start) &&
      moment($scope.weekDay(4)).isBefore(end)

    $scope.fridayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(5), 'day') ||
      moment($scope.weekDay(5)).isAfter(start) &&
      moment($scope.weekDay(5)).isBefore(end)

    $scope.saturdayTime = (start, end) ->
      moment(start).isSame($scope.weekDay(6), 'day') ||
      moment($scope.weekDay(6)).isAfter(start) &&
      moment($scope.weekDay(6)).isBefore(end)
]

