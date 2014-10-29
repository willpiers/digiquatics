@digiquatics.controller 'ShiftsCtrl', [
  '$q'
  '$scope'
  'Shifts'
  'SubRequests'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  'ScheduleHelper'
  '$window'
  'Window'

  class ShiftsCtrl
    constructor: (@$q, @$scope, @Shifts, @SubRequests, @Users, @Locations, @Positions, $modal, @ScheduleHelper, $window, Window) ->
      @$scope.state = {}
      @$scope.state.buildMode = true
      @$scope.days = @ScheduleHelper.days
      @$scope.predicate = value: 'last_name'

      @_loadAndProcessData()

      @$scope.$on 'shifts:created', _.bind @_addViewDataToUsers, @

      @$scope.print = _.bind $window.print, $window

      @$scope.previous = => @_changeDay if Window.xs then -1 else -7
      @$scope.next = => @_changeDay if Window.xs then 1 else 7

      @$scope.previousMonth = => @_changeDay if Window.xs then -7 else -28
      @$scope.nextMonth = => @_changeDay if Window.xs then 7 else 28

      @$scope.resetWeekCounter = =>
        @ScheduleHelper.daysFromToday = 0
        @_addViewDataToUsers()

      @$scope.currentDayName = =>
        moment().add(@ScheduleHelper.daysFromToday, 'days').format 'dddd'

      @$scope.currentDayOfWeek = =>
        moment().add(@ScheduleHelper.daysFromToday, 'days').format 'd'

      @$scope.displayStartDate = =>
        if Window.xs
          moment().add(@ScheduleHelper.daysFromToday, 'days').format 'MMM D'
        else
          moment().startOf('week').add(@ScheduleHelper.daysFromToday, 'days').format 'MMMM YYYY'

      @$scope.weekDay = _.bind @ScheduleHelper.weekDay, @ScheduleHelper # check to see if it works without bind

      @$scope.open = (user, day, shift, size) =>
        if @$scope.state.userIsAdmin
          $modal.open
            templateUrl: 'scheduling/shift-assigner.html'
            controller: 'ShiftModalCtrl as controller'
            size: size
            resolve:
              shift: -> shift
              data: =>
                user: user
                day: day
                location: @$scope.state.buildLocation
                startTime: @$scope.weekDay(day).startOf('day').add 5, 'hours'
                endTime: @$scope.weekDay(day).startOf('day').add 10, 'hours'
                positions: $scope.positions
                position: user.position_id

    _changeDay: (days) ->
      @ScheduleHelper.daysFromToday += days
      @_addViewDataToUsers()

    _loadAndProcessData: ->
      @$q.all
        users: @Users.index().$promise
        locations: @Locations.index().$promise
        positions: @Positions.index().$promise
        subRequests: @SubRequests.index().$promise
      .then ({users, locations, positions, subRequests}) =>
        @$scope.locations = locations
        @$scope.positions = positions
        @$scope.users = users
        @$scope.subRequests = subRequests

        @_addViewDataToUsers()

    _addViewDataToUsers: ->
      _.each @$scope.users, (user) =>
        user.weeklyHours = @_calculateHours user
        _.each user.time_off_requests, @_addDayIndicesToTimeOffRequests, @
        _.each user.shifts, @_addShiftData, @
        _.each user.shifts, @_addColorToShift, @

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
        startOfWeek = moment().startOf('week').add @ScheduleHelper.daysFromToday, 'days'
        endOfWeek = moment().endOf('week').add @ScheduleHelper.daysFromToday, 'days'

        weekRange = moment().range startOfWeek, endOfWeek

        if request.all_day
          requestRange = moment().range moment(request.starts_at), moment(request.ends_at)

          if weekRange.overlaps requestRange
            requestRangeDuringThisWeek = weekRange.intersect requestRange

            requestRangeDuringThisWeek.by 'days', (momentDay) ->
              request.dayIndices.push momentDay.weekday()
        else
          if moment(request.starts_at).within weekRange
            request.dayIndices.push moment(request.starts_at).weekday()

    _addShiftData: (shift) ->
      delete shift.dayIndex if shift.dayIndex?

      shiftStartTime = moment shift.start_time
      selectedDay = moment().startOf('week').add @ScheduleHelper.daysFromToday, 'days'

      if shiftStartTime.isSame selectedDay, 'week'
        shift.dayIndex = shiftStartTime.weekday()
        @_addColorToShift shift

    _addColorToShift: (shift) ->
      shift.color = if _.size(@subRequests, shift_id: shift.id) then 'warning' else 'primary'
]
