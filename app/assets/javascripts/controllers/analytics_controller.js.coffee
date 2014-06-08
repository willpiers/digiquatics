@digiquatics.controller 'AnalyticsCtrl', ['$scope',
  @AnalyticsControllerCtrl = ($scope) ->
    $scope.today1 = ->
      $scope.dt1 = new Date()
      return

    $scope.today2 = ->
      $scope.dt2 = new Date()
      return

    $scope.today1()
    $scope.today2()

    $scope.open1 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened1 = true
      return

    $scope.open2 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened2 = true
      return

    $scope.dateOptions =
      "year-format": "'yy'"
      "starting-day": 1

    $scope.mytime = new Date()
    $scope.hstep = 1
    $scope.options =
      hstep: [
        1
        2
        3
      ]
      mstep: [
        1
        5
        10
        15
        25
        30
      ]

    $scope.ismeridian = true
    $scope.toggleMode = ->
      $scope.ismeridian = not $scope.ismeridian
      return

    $scope.update = ->
      d = new Date()
      d.setHours 14
      d.setMinutes 0
      $scope.mytime = d
      return

    $scope.changed = ->
      console.log "Time changed to: " + $scope.mytime
      return

    $scope.clear = ->
      $scope.mytime = null
      return

    return
]
