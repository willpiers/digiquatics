@digiquatics.controller 'ShiftsCtrl', [
  '$scope'
  '$filter'
  'Shifts'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  '$log'
  'ScheduleHelper'

  @ShiftsCtrl = ($scope, $filter, Shifts, Users, Locations, Positions,
                 $modal, $log, ScheduleHelper) ->
    angular.extend $scope, ScheduleHelper

    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.calculateHours = (user) ->
      _.reduce user.shifts, (total, shift) ->
        if moment(shift.start_time).isSame $scope.weekDay(0), 'week'
          total += moment(shift.end_time).diff(shift.start_time, 'hours', true)

        total
      , 0

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
      moment().startOf('week').add('days', $scope.weekCounter + days).format('MMM D, YYYY')

    $scope.weekDay = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days)

    $scope.predicate =
      value: 'last_name'

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
      modalInstance = $modal.open
        templateUrl: 'scheduling/shift-assigner.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          shift: ->
            shift
          user: ->
            user
          location: ->
            $scope.buildLocation
          startTime: ->
            startTime(day)
          endTime: ->
            endTime(day)
          positions: ->
            $scope.positions
          position: ->
            user.position_id
          day: ->
            day


    ModalInstanceCtrl = ($scope, $modalInstance, shift, user, location,
                         startTime, endTime, positions, position, day) ->
      $scope.day = day
      $scope.user = user
      $scope.shift = shift
      $scope.positions = positions
      $scope.positionSelect = shift?.position_id ? position
      $scope.startTime = shift?.start_time ? startTime
      $scope.endTime = shift?.end_time ? endTime
      $scope.range = _.range(1,10)
      $scope.occurences = $scope.range[0]
      $scope.daysChecked = [
        {day: 'Sunday', checked: false }
        {day: 'Monday', checked: false }
        {day: 'Tuesday', checked: false }
        {day: 'Wednesday', checked: false }
        {day: 'Thursday', checked: false }
        {day: 'Friday', checked: false }
        {day: 'Saturday', checked: false }
      ]

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
          for weekCounter in [0..$scope.occurences-1] by 1
            for dayCounter in [0..5] by 1
              if $scope.daysChecked[dayCounter].checked
                adjustedDayCounter = dayCounter - $scope.day
                Shifts.create
                  user_id: user.id
                  location_id: location
                  position_id: position
                  start_time: moment(start).add(weekCounter, 'weeks').add(adjustedDayCounter, 'days')
                  end_time: moment(end).add(weekCounter, 'weeks').add(adjustedDayCounter, 'days')
                .$promise.then (newShift) ->
                  user.shifts.push newShift

      $scope.ok = (position, startTime, endTime) ->
        $scope.assignShift user, location, position, startTime, endTime, shift
        $modalInstance.close $scope.user

        if shift then toastr.info('Shift was successfully updated.')
        else toastr.success('Shift was successfully created.')
        true #Fixes error with returns elements through Angular to the DOM

      $scope.cancel = ->
        $modalInstance.dismiss 'Cancel'

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
      'user'
      'location'
      'startTime'
      'endTime'
      'positions'
      'position'
      'day'
    ]
]
