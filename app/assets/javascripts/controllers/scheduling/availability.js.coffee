@digiquatics.controller 'AvailabilityCtrl', [
  '$scope', 'Availabilities', '$modal', '$log',

  @AvailabilityCtrl = ($scope, Availabilities, $modal, $log) ->
    $scope.days = [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]

    $scope.availabilities = availabilities.my_availability()

    $scope.open = (day, availability, size) ->
      modalInstance = $modal.open(
        templateUrl: 'scheduling/availability.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          day: ->
            day
          availability: ->
            availability
      )

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, day, availability) ->
      $scope.day = day
      $scope.availability = availability
      $scope.startTime = if availability then availability.start_time else startTime
      $scope.endTime = if availability then availability.end_time else endTime

      $scope.assignAvailability = (availability, start, end) ->
        if availability
          $id = availability.id
          availability.start_time = start
          availability.end_time = end
          availabilities.update({ id:$id }, availability)
        else availabilities.create
          start_time: start
          end_time: end

      $scope.deleteAvailability = (availability) ->
        $id = availability.id
        Availabilities.destroy({ id:$id })

      $scope.ok = (startTime, endTime) ->
        $scope.assignAvailability(availability, startTime, endTime)
        $modalInstance.close($scope.availability)

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        $scope.deleteAvailability(availability)
        $modalInstance.close($scope.availability)

      $scope.startTime = (days) ->
        start = new Date()
        start.setDate($scope.weekDay(days).format('DD'))
        start.setHours(7)
        start.setMinutes(0)
        start

      $scope.endTime = (days) ->
        end = new Date()
        end.setDate($scope.weekDay(days).format('DD'))
        end.setHours(8)
        end.setMinutes(0)
        end
]

@digiquatics.controller 'availabilitysCtrl', ['$scope', '$filter', 'availabilitys', 'Users',
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
        console.log "Before length: " + $scope.user.shifts.length
        $scope.user.shifts.splice(shift.$index, 1)
        console.log "After length: " + $scope.user.shifts.length
        # $id = shift.id
        # Shifts.destroy({ id:$id })

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
      start.setDate($scope.weekDay(days).format('DD'))
      start.setHours(7)
      start.setMinutes(0)
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setDate($scope.weekDay(days).format('DD'))
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
]


