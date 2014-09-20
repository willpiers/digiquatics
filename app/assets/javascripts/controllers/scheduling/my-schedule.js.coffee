@digiquatics.controller 'MyScheduleCtrl', [
  '$scope'
  'Shifts'
  'MyShifts'
  'Locations'
  'Positions'
  'SubRequests'
  '$modal'
  '$log'
  'ScheduleHelper'

  @MyScheduleCtrl = ($scope, Shifts, MyShifts, Locations, Positions,
                     SubRequests, $modal, $log, ScheduleHelper) ->
    angular.extend $scope, ScheduleHelper
    # Services
    $scope.myShifts = MyShifts.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()
    $scope.subRequests = SubRequests.index()

    $scope.calculateHours = (user) ->
      shifts = user.shifts
      total = 0
      for shift in shifts
        if moment(shift.start_time).isSame($scope.weekDay(0), 'week')
          hours = moment(shift.end_time).hours() - moment(shift.start_time).hours()
          minutes = moment(shift.end_time).minutes() - moment(shift.start_time).minutes()
          hours = hours + ( minutes / 60 )
          total += hours
      total

    $scope.weekCounter = 0

    $scope.previousWeek = ->
      $scope.weekCounter -= 7

    $scope.nextWeek = ->
      $scope.weekCounter += 7

    $scope.resetWeekCounter = ->
      $scope.weekCounter = 0

    $scope.displayStartDate = ->
      moment().startOf('week').add('days', $scope.weekCounter).format('MMM D')

    $scope.displayEndDate = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days).format('MMM D, YYYY')

    $scope.weekDay = (days) ->
      moment().startOf('week').add('days', $scope.weekCounter + days)

    # show shifts by day of week
    $scope.sameDay = (shift, day) ->
      moment(shift).isSame($scope.weekDay(day), 'day')

    # Show Time off request over multiple days
    $scope.sameDayTimeOff = (request, day) ->
      if request.approved
        moment(request.starts_at).isSame($scope.weekDay(day), 'day') or
        moment($scope.weekDay(day)).isAfter(request.starts_at) and
        moment($scope.weekDay(day)).isBefore(request.ends_at)

    $scope.predicate =
      value: 'shift.start_time'

    $scope.open = (shift, size) ->
      modalInstance = $modal.open
        templateUrl: 'sub-request.html',
        controller: MyScheduleModalCtrl,
        size: size,
        resolve:
          shift: -> shift
          SubRequests: -> SubRequests

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())
]
