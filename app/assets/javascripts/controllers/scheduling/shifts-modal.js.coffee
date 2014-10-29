@digiquatics.controller 'ShiftModalCtrl', [
  '$q'
  '$scope'
  '$rootScope'
  '$modalInstance'
  'shift'
  'data'
  'Shifts'

  class ShiftModalCtrl
    constructor: (@$q, @$scope, @$rootScope, @$modalInstance, @shift, @data, @Shifts) ->
      {@user, @day, @location} = @data

      angular.extend @$scope,
        user: @user
        shift: @shift
        positions: @data.positions
        positionSelect: @shift?.position_id ? @data.position
        startTime: @shift?.start_time ? @data.startTime
        endTime: @shift?.end_time ? @data.endTime
        weekSelectBox: [1..10]

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

    ok: (position, startTime, endTime) =>
      @_assignShift position, startTime, endTime
      .then => @$rootScope.$broadcast 'shifts:created'

      @$modalInstance.close @user

    cancel: -> @$modalInstance.dismiss 'Cancel'

    delete: =>
      @$modalInstance.close @user

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
              adjustedDayCounter = day - @data.day - 1

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
