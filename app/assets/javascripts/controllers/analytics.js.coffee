@digiquatics.controller 'AnalyticsCtrl', [
  '$scope'

  @AnalyticsControllerCtrl = ($scope) ->
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

    $scope.mytime = new Date()

    d1 = new Date()
    d1.setHours 0
    d1.setMinutes 1
    $scope.mytime1 = d1

    $scope.mytime2 = new Date()

    d2 = new Date()
    d2.setHours 23
    d2.setMinutes 59
    $scope.mytime2 = d2

    $scope.hstep = 1

    $scope.ismeridian = true

    $scope.changed = ->
      console.log "Time changed to: " + $scope.mytime

    # Used to show and hide form elements on user stats
    $scope.requestMode = 'graphical'

    $scope.graphicalMode = ->
      $scope.requestMode  == 'numerical'

    $scope.numericalMode = ->
      $scope.requestMode  == 'graphical'
]
