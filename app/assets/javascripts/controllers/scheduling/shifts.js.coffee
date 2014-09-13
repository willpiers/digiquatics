@digiquatics.controller 'ShiftsCtrl', [
  '$scope'
  '$filter'
  'Shifts'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  '$log'
  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions, $modal, $log) ->
    # Services
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.calculateHours = (user) ->
      shifts = user.shifts
      total = 0
      for shift in shifts
        hours = moment(shift.end_time).hours() - moment(shift.start_time).hours()
        minutes = moment(shift.end_time).minutes() - moment(shift.start_time).minutes()
        hours = hours + ( minutes / 60 )
        total += hours
      total

    $scope.startTime = (days) ->
      start = new Date()
      start.setMonth($scope.weekDay(days).format('MM') - 1)
      start.setDate($scope.weekDay(days).format('DD'))
      start.setHours(7)
      start.setMinutes(0)
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setMonth($scope.weekDay(days).format('MM') - 1)
      end.setDate($scope.weekDay(days).format('DD'))
      end.setHours(8)
      end.setMinutes(0)
      end

    $scope.buildMode = 'Build'

    $scope.build = ->
      $scope.buildMode is 'Build'

    $scope.weekCounter = 0

    $scope.previousWeek = ->
      $scope.weekCounter -= 7

    $scope.nextWeek = ->
      $scope.weekCounter += 7

    $scope.resetWeekCounter = ->
      $scope.weekCounter = 0

    $scope.displayStartDate = ->
      moment().startOf('week').add('days', $scope.weekCounter).format('MMMM YYYY')

    ##### Might not need this
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
    $scope.sameDayTimeOff = (request, day) ->
      if request.approved
        moment(request.starts_at).isSame($scope.weekDay(day), 'day') or
        moment($scope.weekDay(day)).isAfter(request.starts_at) and
        moment($scope.weekDay(day)).isBefore(request.ends_at)

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
      $scope.shift = shift
      $scope.positions = positions
      $scope.positionSelect = if shift then shift.position_id else position
      $scope.startTime = if shift then shift.start_time else startTime
      $scope.endTime = if shift then shift.end_time else endTime

      $scope.assignShift = (user, location, position, start, end, shift) ->
        if shift
          shiftData = angular.extend shift,
            start_time: start
            end_time: end
            position_id: position

          Shifts.update id: shiftData.id, shiftData
          .$promise.then (updatedShift) ->
            _.remove user.shifts, (userShift) -> userShift.id is shift.id
            user.shifts.push updatedShift
        else
          Shifts.create
            user_id: user.id
            location_id: location
            position_id: position
            start_time: start
            end_time: end
          .$promise.then (newShift) ->
            user.shifts.push newShift

      $scope.ok = (position, startTime, endTime) ->
        $scope.assignShift user, location, position, startTime, endTime, shift
        $modalInstance.close $scope.user

        if shift
          toastr.info('Shift was successfully updated.')
          return true #Fixes error with returns elements through Angular to the DOM
        else
          toastr.success('Shift was successfully created.')
          return true #Fixes error with returns elements through Angular to the DOM

      $scope.cancel = ->
        $modalInstance.dismiss 'Cancel'

      $scope.delete = ->
        Shifts.destroy id: shift.id
        _.remove user.shifts, (userShift) -> userShift.id is shift.id
        $modalInstance.close $scope.user
        toastr.error('Shift was successfully deleted.')
        return true #Fixes error with returns elements through Angular to the DOM

    ModalInstanceCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'shift'
      'user'
      'location'
      'startTime'
      'endTime'
      'positions'
      'position'
    ]
]
