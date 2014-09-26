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
          controller: @ShiftModalInstanceCtrl
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

    _updateViewWithNewShift: (user, newShift) ->
      user.shifts.push newShift
      @_addViewDataToUsers()

]
