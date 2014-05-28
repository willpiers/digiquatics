@digiquatics.controller 'ShiftReportsCtrl', ['$scope', 'ShiftReports',
                                             'Locations'
  @ShiftReportsCtrl = ($scope, ShiftReports, Locations) ->

    $scope.starNew = (data) ->
      d = new Date() # today!
      x = 7 # go back 5 days!
      if data.created_at > (d - 7) then true

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.shiftReports = ShiftReports.index()

    $scope.locations       = Locations.index()
]
