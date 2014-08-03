@digiquatics.controller 'ShiftsCtrl', ['$scope', '$filter', 'Shifts', 'Users',
                                       'Locations', 'Positions', '$modal', '$log',
  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions, $modal, $log) ->
    # Services
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Weeks
    $scope.open = (user, day, shift, size) ->
      modalInstance = $modal.open(
        templateUrl: 'scheduling/shift-assigner.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          shift: ->
            shift
          user: ->
            user
          day: ->
            day
          location: ->
            $scope.buildLocation
          startTime: ->
            $scope.startTime(day)
          endTime: ->
            $scope.endTime(day)
          positions: ->
            $scope.positions
          position: ->
            user.position_id
        )

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, shift, user, location, startTime, endTime, positions, position) ->
      $scope.user = user
      $scope.positions = positions
      $scope.positionSelect = if shift then shift.position_id else position
      $scope.startTime = if shift then shift.start_time else startTime
      $scope.endTime = if shift then shift.end_time else endTime
      $scope.assignShift = (user, location, position, start, end, shift) ->
        if shift
          $id = shift.id
          shift.start_time = start
          shift.end_time = end
          shift.position_id = position
          Shifts.update({ id:$id }, shift)
        else Shifts.create
          user_id: user.id
          location_id: location
          position_id: position
          start_time: start
          end_time: end
      $scope.deleteShift = (shift) ->
        $id = shift.id
        Shifts.destroy({ id:$id })
      $scope.ok = (position, startTime, endTime) ->
        $scope.assignShift(user, location, position, startTime, endTime, shift)
        $modalInstance.close($scope.user)
        return

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"
        return

      $scope.delete = ->
        $scope.deleteShift(shift)
        $modalInstance.close($scope.user)
        return

      return

    $scope.startTime = (days) ->
      start = new Date()
      start.setUTCDate($scope.weekDay(days).format('DD'))
      start.setHours(7)
      start.setMinutes(0)
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setUTCDate($scope.weekDay(days).format('DD'))
      end.setHours(8)
      end.setMinutes(0)
      end

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

    $scope.sameDay = (shift, day) ->
      moment(shift).isSame($scope.weekDay(day), 'day')

    # Show Time off request over multiple days
    $scope.sameDayTimeOff = (start, end, day) ->
      moment(start).isSame($scope.weekDay(day), 'day') ||
      moment($scope.weekDay(day)).isAfter(start) &&
      moment($scope.weekDay(day)).isBefore(end)
]

