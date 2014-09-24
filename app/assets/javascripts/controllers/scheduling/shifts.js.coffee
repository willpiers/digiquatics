@digiquatics.controller 'ShiftsCtrl', [
  '$q'
  '$scope'
  'Shifts'
  'Users'
  'Locations'
  'Positions'
  '$modal'

  class ShiftsCtrl
    constructor: (@$q, @$scope, @Shifts, @Users, @Locations, @Positions, $modal) ->
      @currentWeek = 0

      @_loadAndProcessData()

      @$scope.days = [
        'Sunday'
        'Monday'
        'Tuesday'
        'Wednesday'
        'Thursday'
        'Friday'
        'Saturday'
      ]

      @$scope.buildMode = true

      @$scope.previousWeek = =>
        @currentWeek -= 7
        @_addViewDataToUsers()

      @$scope.nextWeek = =>
        @currentWeek += 7
        @_addViewDataToUsers()

      @$scope.resetWeekCounter = =>
        @currentWeek = 0
        @_addViewDataToUsers()

      @$scope.displayStartDate = =>
        moment().startOf('week').add('days', @currentWeek).format 'MMMM YYYY'

      @$scope.displayEndDate = (days) =>
        moment().startOf('week').add('days', @currentWeek + days).format 'MMM D, YYYY'

      @$scope.weekDay = (days) =>
        moment().startOf('week').add 'days', @currentWeek + days

      @$scope.predicate =
        value: 'last_name'

      @$scope.open = (user, day, shift, size) =>
        modalInstance = $modal.open
          templateUrl: 'scheduling/shift-assigner.html'
          controller: ModalInstanceCtrl
          size: size
          resolve:
            shift: -> shift
            data: =>
              user: user
              day: day
              location: $scope.buildLocation
              startTime: @$scope.weekDay(day).startOf('day').add 5, 'hours'
              endTime: @$scope.weekDay(day).startOf('day').add 10, 'hours'
              positions: $scope.positions
              position: user.position_id

      ModalInstanceCtrl = ($scope, $modalInstance, shift, data) =>
        $scope.user = data.user
        $scope.shift = shift
        $scope.positions = data.positions
        $scope.positionSelect = shift?.position_id ? data.position
        $scope.startTime = shift?.start_time ? data.startTime
        $scope.endTime = shift?.end_time ? data.endTime
        $scope.range = _.range(1,10)
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
          occurences: $scope.range[0]

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
              for weekCounter in [0..$scope.state.occurences-1] by 1
                for dayCounter in [0..6] by 1
                  if $scope.daysChecked[dayCounter].checked
                    adjustedDayCounter = dayCounter - data.day
                    @Shifts.create
                      user_id: user.id
                      location_id: location
                      position_id: position
                      start_time: moment(start).add(weekCounter, 'weeks').add(adjustedDayCounter, 'days')
                      end_time: moment(end).add(weekCounter, 'weeks').add(adjustedDayCounter, 'days')
                    .$promise.then (newShift) =>
                      user.shifts.push newShift
                      @_addViewDataToUsers()
            else
              @Shifts.create
                user_id: user.id
                location_id: location
                position_id: position
                start_time: start
                end_time: end
              .$promise.then (newShift) =>
                user.shifts.push newShift
                @_addViewDataToUsers()

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

      ModalInstanceCtrl['$inject'] = [
        '$scope'
        '$modalInstance'
        'shift'
        'data'
      ]

    _loadAndProcessData: ->
      @$q.all
        users: @Users.index().$promise
        locations: @Locations.index().$promise
        positions: @Positions.index().$promise
      .then ({users, locations, positions}) =>
        @$scope.locations = locations
        @$scope.positions = positions
        @$scope.users = users

        @_addViewDataToUsers()

    _addViewDataToUsers: ->
      _.each @$scope.users, (user) =>
        user.hours = @_calculateHours user
        _.each user.time_off_requests, @_addDayIndicesToTimeOffRequests, @
        _.each user.shifts, @_addDayIndexToShift, @

    _calculateHours: (user) ->
      _.reduce user.shifts, (total, shift) =>
        if moment(shift.start_time).isSame @$scope.weekDay(0), 'week'
          total += moment(shift.end_time).diff(shift.start_time, 'hours', true)

        total
      , 0

    _addDayIndicesToTimeOffRequests: (request) ->
      request.dayIndices = []

      if request.approved
        startOfWeek = moment().startOf('week').add 'days', @currentWeek
        endOfWeek = moment().endOf('week').add 'days', @currentWeek

        weekRange = moment().range startOfWeek, endOfWeek

        if request.all_day
          requestRange = moment().range moment(request.starts_at), moment(request.ends_at)

          if weekRange.overlaps requestRange
            requestRangeDuringThisWeek = weekRange.intersect requestRange

            requestRangeDuringThisWeek.by 'days', (momentDay) ->
              request.dayIndices.push momentDay.day()
        else
          if moment(request.starts_at).within weekRange
            request.dayIndices.push moment(request.starts_at).day()

    _addDayIndexToShift: (shift) ->
      delete shift.dayIndex if shift.dayIndex?

      shiftStartTime = moment shift.start_time

      if shiftStartTime.isSame moment().startOf('week').add('days', @currentWeek), 'week'
        shift.dayIndex = shiftStartTime.day()
]
