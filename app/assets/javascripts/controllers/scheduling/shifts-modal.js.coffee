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
      {@user, @day, @location} = @data

      @$scope.user = @user
      @$scope.shift = @shift
      @$scope.positions = @data.positions
      @$scope.positionSelect = @shift?.position_id ? @data.position
      @$scope.startTime = @shift?.start_time ? @data.startTime
      @$scope.endTime = @shift?.end_time ? @data.endTime

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
        @_assignShift position, startTime, endTime
        .then => @$rootScope.$broadcast 'newShiftCreated'

        $modalInstance.close @user

      @$scope.cancel = -> $modalInstance.dismiss 'Cancel'

      @$scope.delete = =>
        $modalInstance.close @user

        @Shifts.destroy id: @shift.id
        .$promise.then =>
          _.remove @user.shifts, id: @shift.id
          toastr.error 'Shift was successfully deleted.'

    _assignShift: (position, start, end) ->
      if @shift
        shiftData = angular.extend @shift,
          start_time: start
          end_time: end
          position_id: position

        @Shifts.update id: shiftData.id, shiftData
        .$promise.then (updatedShift) =>
          _.remove @user.shifts, id: updatedShift.id
          @user.shifts.push updatedShift
          toastr.info 'Shift was successfully updated.'
      else
        @_createShifts {position, start, end}
        .then (newShifts) =>
          @user.shifts = @user.shifts.concat newShifts
          toastr.success 'Shift was successfully created.'

    _createShifts: ({position, start, end}) ->
      if @$scope.state.recurring
        promises = []

        _.each [0..(@$scope.state.occurences - 1)], (week) =>
          _.each [0..6], (day) =>
            if @$scope.daysChecked[day].checked
              adjustedDayCounter = day - @data.day

              shiftResource = @Shifts.create
                user_id: @user.id
                location_id: @location
                position_id: position
                start_time: moment(start).add(week, 'weeks').add adjustedDayCounter, 'days'
                end_time: moment(end).add(week, 'weeks').add adjustedDayCounter, 'days'

              promises.push shiftResource.$promise

        @$q.all promises

      else
        @Shifts.create
          user_id: @user.id
          location_id: @location
          position_id: position
          start_time: start
          end_time: end
        .$promise

]
