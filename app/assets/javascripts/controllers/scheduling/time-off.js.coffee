@digiquatics.controller 'TimeOffCtrl', ['$scope', 'TimeOff', 'Users',
                                       'Locations', 'Positions',
  @UsersCtrl = ($scope, TimeOff, Users, Locations, Positions) ->
    # Services
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Used to show and hide form elements on new time off request
    $scope.requestMode = 'partialDay'

    $scope.allDayRequestMode = ->
      $scope.requestMode  == 'allDay'

    $scope.partialDayRequestMode = ->
      $scope.requestMode  == 'partialDay'

    # Date picker defaults
    $scope.today1 = ->
      $scope.dt1 = new Date()

    $scope.today2 = ->
      $scope.dt2 = new Date()

    $scope.today1()
    $scope.today2()

    $scope.open1 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened1 = true

    $scope.open2 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened2 = true

    $scope.dateOptions =
      "year-format": "'yy'"
      "starting-day": 1

    $scope.setPartial1 = ->
      partialDayStartTime = new Date()
      partialDayStartTime.setHours 7
      partialDayStartTime.setMinutes 0
      partialDayStartTime.setSeconds 0
      $scope.partialDayStartTime = partialDayStartTime

    $scope.setPartial2 = ->
      partialDayEndTime = new Date()
      partialDayEndTime.setHours 8
      partialDayEndTime.setMinutes 0
      partialDayEndTime.setSeconds 0
      $scope.partialDayEndTime = partialDayEndTime

    $scope.setAll1 = ->
      allDayStartTime = new Date()
      allDayStartTime.setHours 0
      allDayStartTime.setMinutes 1
      allDayStartTime.setSeconds 0
      $scope.allDayStartTime = allDayStartTime

    $scope.setAll2 = ->
      allDayEndTime = new Date()
      allDayEndTime.setHours 23
      allDayEndTime.setMinutes 59
      allDayEndTime.setSeconds 0
      $scope.allDayEndTime = allDayEndTime

    $scope.setPartial1()
    $scope.setPartial2()
    $scope.setAll1()
    $scope.setAll2()

    $scope.hstep = 1

    $scope.ismeridian = true

    $scope.changed = ->
      console.log "Time changed to: " + $scope.mytime

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.hasReason = (request) ->
      request.reason
]
