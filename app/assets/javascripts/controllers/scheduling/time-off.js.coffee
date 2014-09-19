@digiquatics.controller 'TimeOffCtrl', [
  '$scope'
  'TimeOff'
  'Users'
  'Locations'
  'Positions'
  'TimeOffHelper'

  @TimeOffCtrl = ($scope, TimeOff, Users, Locations, Positions, TimeOffHelper) ->
    angular.extend $scope, TimeOffHelper
    # Services
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Used to show and hide form elements on new time off request
    $scope.requestMode = 'partialDay'

    $scope.allDayRequestMode = ->
      $scope.requestMode is 'allDay'

    $scope.partialDayRequestMode = ->
      $scope.requestMode is 'partialDay'

    # Date picker defaults
    $scope.today1 = ->
      $scope.dt1 = moment().format('YYYY-MM-DD')

    $scope.today2 = ->
      $scope.dt2 = moment().format('YYYY-MM-DD')

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
      $scope.partialDayStartTime = moment().startOf('day').add 7, 'hours'

    $scope.setPartial2 = ->
      $scope.partialDayEndTime = moment().startOf('day').add 8, 'hours'

    $scope.setAll1 = ->
      $scope.allDayStartTime = moment().startOf('day').add 1, 'minutes'

    $scope.setAll2 = ->
      $scope.allDayEndTime = moment().startOf('day').add(23, 'hours').add(59, 'minutes')

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
]
