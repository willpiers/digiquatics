@digiquatics.controller 'ShiftModalInstanceCtrl', [
  '$q'
  '$scope'
  '$rootScope'
  '$modalInstance'
  'shift'
  'data'
  'Shifts'

  class ShiftModalInstanceCtrl
    constructor: (@$q, @$scope, @$rootScope, $modalInstance, @shift, @data, @Shifts) ->
      @$scope.user = data.user
      @$scope.shift = shift
      @$scope.positions = data.positions
      @$scope.positionSelect = shift?.position_id ? data.position
      @$scope.startTime = shift?.start_time ? data.startTime
      @$scope.endTime = shift?.end_time ? data.endTime
      @$scope.weekSelectBox = [1..10]
      @$scope.daysChecked = [
        {day: 'Sunday', checked: false }
        {day: 'Monday', checked: false }
        {day: 'Tuesday', checked: false }
        {day: 'Wednesday', checked: false }
        {day: 'Thursday', checked: false }
        {day: 'Friday', checked: false }
        {day: 'Saturday', checked: false }
      ]
      @$scope.state =
        recurring: false
        occurences: @$scope.weekSelectBox[0]

      @$scope.ok = (position, startTime, endTime) =>
        @_assignShift @$scope.user, data.location, position, startTime, endTime, shift
        $modalInstance.close @$scope.user

        if shift
          toastr.info('Shift was successfully updated.')
        else
          toastr.success('Shift was successfully created.')

        true #Fixes error with returns elements through Angular to the DOM

      @$scope.cancel = ->
        $modalInstance.dismiss 'Cancel'

      @$scope.delete = =>
        Shifts.destroy id: shift.id
        _.remove @$scope.user.shifts, (userShift) -> userShift.id is shift.id
        @_addViewDataToUsers()

        $modalInstance.close @$scope.user
        toastr.error('Shift was successfully deleted.')

        true #Fixes error with returns elements through Angular to the DOM

    _assignShift: (user, location, position, start, end, shift) ->
        if shift
          shiftData = angular.extend shift,
            start_time: start
            end_time: end
            position_id: position

          @Shifts.update id: shiftData.id, shiftData
          .$promise.then (updatedShift) =>
            _.remove user.shifts, (userShift) -> userShift.id is shift.id
            user.shifts.push updatedShift
            @_addViewDataToUsers()
        else
          @_createShifts {user, location, position, start, end}
          .then (newShifts) =>
            user.shifts = user.shifts.concat newShifts
            @$rootScope.$broadcast 'newShiftCreated'

    _createShifts: ({user, location, position, start, end}) ->
      if @$scope.state.recurring
        promises = []

        _.each [0..(@$scope.state.occurences - 1)], (week) =>
          _.each [0..6], (day) =>
            if @$scope.daysChecked[day].checked
              adjustedDayCounter = day - @data.day

              shiftResource = @Shifts.create
                user_id: user.id
                location_id: location
                position_id: position
                start_time: moment(start).add(week, 'weeks').add(adjustedDayCounter, 'days')
                end_time: moment(end).add(week, 'weeks').add(adjustedDayCounter, 'days')

              promises.push shiftResource.$promise

        @$q.all promises

      else
        @Shifts.create
          user_id: user.id
          location_id: location
          position_id: position
          start_time: start
          end_time: end
        .$promise
]
