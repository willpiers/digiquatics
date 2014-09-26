@digiquatics.controller 'ShiftModalInstanceCtrl', [
  '$scope'
  '$modalInstance'
  'shift'
  'data'

  class ShiftModalInstanceCtrl
    constructor: (@$scope, $modalInstance, @shift, @data) ->
      $scope.user = data.user
      $scope.shift = shift
      $scope.positions = data.positions
      $scope.positionSelect = shift?.position_id ? data.position
      $scope.startTime = shift?.start_time ? data.startTime
      $scope.endTime = shift?.end_time ? data.endTime
      $scope.weekSelectBox = [1..10]
      $scope.daysChecked = [
        {day: 'Sunday', checked: false }
        {day: 'Monday', checked: false }
        {day: 'Tuesday', checked: false }
        {day: 'Wednesday', checked: false }
        {day: 'Thursday', checked: false }
        {day: 'Friday', checked: false }
        {day: 'Saturday', checked: false }
      ]
      $scope.state =
        recurring: false
        occurences: $scope.weekSelectBox[0]

      assignShift = (user, location, position, start, end, shift) =>
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
          if $scope.state.recurring
            _.each [0..($scope.state.occurences - 1)], (week) =>
              _.each [0..6], (day) =>
                if $scope.daysChecked[day].checked
                  adjustedDayCounter = day - data.day
                  @Shifts.create
                    user_id: user.id
                    location_id: location
                    position_id: position
                    start_time: moment(start).add(week, 'weeks').add(adjustedDayCounter, 'days')
                    end_time: moment(end).add(week, 'weeks').add(adjustedDayCounter, 'days')
                  .$promise.then (newShift) =>
                    @_updateViewWithNewShift user, newShift
          else
            @Shifts.create
              user_id: user.id
              location_id: location
              position_id: position
              start_time: start
              end_time: end
            .$promise.then (newShift) =>
              @_updateViewWithNewShift user, newShift

      $scope.ok = (position, startTime, endTime) ->
        assignShift $scope.user, data.location, position, startTime, endTime, shift
        $modalInstance.close $scope.user

        if shift
          toastr.info('Shift was successfully updated.')
        else
          toastr.success('Shift was successfully created.')

        true #Fixes error with returns elements through Angular to the DOM

      $scope.cancel = ->
        $modalInstance.dismiss 'Cancel'

      $scope.delete = =>
        Shifts.destroy id: shift.id
        _.remove $scope.user.shifts, (userShift) -> userShift.id is shift.id
        @_addViewDataToUsers()

        $modalInstance.close $scope.user
        toastr.error('Shift was successfully deleted.')

        true #Fixes error with returns elements through Angular to the DOM
]
