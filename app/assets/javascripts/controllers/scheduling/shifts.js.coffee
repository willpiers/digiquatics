@digiquatics.controller 'ShiftsCtrl', [
  '$q'
  '$scope'
  'Shifts'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  'ScheduleHelper'

  class ShiftsCtrl
    constructor: (@$q, @$scope, @Shifts, @Users, @Locations, @Positions, $modal, @ScheduleHelper) ->
      @daysFromToday = 0

      @_loadAndProcessData()

      @$scope.days = @ScheduleHelper.days

      @$scope.buildMode = true

      @$scope.$on 'shifts:created', _.bind @_addViewDataToUsers, @

      @$scope.previousWeek = =>
        @daysFromToday -= 7
        @_addViewDataToUsers()

      @$scope.nextWeek = =>
        @daysFromToday += 7
        @_addViewDataToUsers()

      @$scope.previousDay = =>
        @daysFromToday -= 1
        @_addViewDataToUsers()

      @$scope.nextDay = =>
        @daysFromToday += 1
        @_addViewDataToUsers()

      @$scope.resetWeekCounter = =>
        @daysFromToday = 0
        @daysFromToday = 0
        @_addViewDataToUsers()

      @$scope.currentDay = =>
        moment().add('days', @daysFromToday).format 'MMM D'

      @$scope.currentDayName = =>
        moment().add('days', @daysFromToday).format 'dddd'

      @$scope.currentDayOfWeek = =>
        moment().add('days', @daysFromToday).format 'd'

      @$scope.displayStartDate = =>
        moment().startOf('week').add('days', @daysFromToday).format 'MMMM YYYY'

      @$scope.displayEndDate = (days) =>
        moment().startOf('week').add('days', @daysFromToday + days).format 'MMM D, YYYY'

      @$scope.weekDay = (days) =>
        moment().startOf('week').add 'days', @daysFromToday + days

      @$scope.predicate =
        value: 'last_name'

      @$scope.open = (user, day, shift, size) =>
        modalInstance = $modal.open
          templateUrl: 'scheduling/shift-assigner.html'
          controller: 'ShiftModalCtrl as controller'
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
        user.weeklyHours = @_calculateHours user
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

      if request.approved or request.active
        request.color = 'danger' if request.approved
        request.color = 'warning' if request.active
        startOfWeek = moment().startOf('week').add 'days', @daysFromToday
        endOfWeek = moment().endOf('week').add 'days', @daysFromToday

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

      if shiftStartTime.isSame moment().startOf('week').add('days', @daysFromToday), 'week'
        shift.dayIndex = shiftStartTime.day()

]
