@digiquatics.controller 'ShiftsCtrl', [
  '$scope'
  '$filter'
  'Shifts'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  '$window'

  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions, $modal, $window) ->
    $scope.users = Users.index (users) ->
      _.each users, (user) ->
        user.hours = _.reduce user.shifts, (total, shift) ->
          if moment(shift.start_time).isSame $scope.weekDay(0), 'week'
            total += moment(shift.end_time).diff(shift.start_time, 'hours', true)

          total
        , 0

        _.each user.time_off_requests, (request) ->
          request.dayIndices = []

          if request.approved
            weekRange = moment().range moment().startOf('week'), moment().endOf('week')

            if request.all_day
              requestRange = moment().range moment(request.starts_at), moment(request.ends_at)

              if weekRange.overlaps requestRange
                requestRangeDuringThisWeek = weekRange.intersect requestRange

                requestRangeDuringThisWeek.by 'days', (momentDay) ->
                  request.dayIndices.push momentDay.day()
            else
              if moment(request.starts_at).within weekRange
                request.dayIndices.push moment(request.starts_at).day()

        _.each user.shifts, (shift) ->
          shiftStartTime = moment shift.start_time

          if shiftStartTime.isSame moment().startOf('week'), 'week'
            shift.dayIndex = shiftStartTime.day()

        # user.shifts = _.filter user.shifts, (shift) ->
        #   moment(shift.start_time).isSame(moment().startOf('week'), 'week')

    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.days = [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]

    startTime = (days) ->
      $scope.weekDay(days).startOf('day').add 5, 'hours'

    endTime = (days) ->
      $scope.weekDay(days).startOf('day').add 10, 'hours'

    $scope.buildMode = true

    $scope.weekCounter = 0

    $scope.previousWeek = ->
      # should send a request with a query param to load more weeks
      $scope.weekCounter -= 7

    $scope.nextWeek = ->
      # should send a request with a query param to load more weeks
      $scope.weekCounter += 7

    $scope.resetWeekCounter = ->
      $scope.weekCounter = 0

    $scope.displayStartDate = ->
      moment().startOf('week').add('days', $scope.weekCounter).format 'MMMM YYYY'

    $scope.displayEndDate = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days).format 'MMM D, YYYY'

    $scope.weekDay = (days) ->
      moment().startOf('week').add 'days', $scope.weekCounter + days

    $scope.predicate =
      value: 'last_name'

    $scope.open = (user, day, shift, size) ->
      modalInstance = $modal.open
        templateUrl: 'scheduling/shift-assigner.html'
        controller: ModalInstanceCtrl
        size: size
        resolve:
          shift: -> shift
          data: ->
            user: user
            day: day
            location: $scope.buildLocation
            startTime: startTime day
            endTime: endTime day
            positions: $scope.positions
            position: user.position_id

    ModalInstanceCtrl = ($scope, $modalInstance, shift, data) ->
      $scope.user = data.user
      $scope.shift = shift
      $scope.positions = data.positions
      $scope.positionSelect = shift?.position_id ? data.position
      $scope.startTime = shift?.start_time ? data.startTime
      $scope.endTime = shift?.end_time ? data.endTime

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
        else
          toastr.success('Shift was successfully created.')

        true #Fixes error with returns elements through Angular to the DOM

      $scope.cancel = ->
        $modalInstance.dismiss 'Cancel'

      $scope.changed = ->
        console.log 'here'

      $scope.delete = ->
        Shifts.destroy id: shift.id
        _.remove user.shifts, (userShift) -> userShift.id is shift.id
        $modalInstance.close $scope.user
        toastr.error('Shift was successfully deleted.')
        true #Fixes error with returns elements through Angular to the DOM

    ModalInstanceCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'shift'
      'data'
    ]
]
