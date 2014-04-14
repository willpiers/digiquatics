@digiquatics.controller 'ShiftReportsCtrl', ['$scope', 'ShiftReports',
                                             'Locations'
  @ShiftReportsCtrl = ($scope, ShiftReports, Locations) ->

    $scope.totalDisplayed = 20

    $scope.loadMore = ->
      $scope.totalDisplayed += 100

    $scope.shiftReports = ShiftReports.index()

    $scope.locations       = Locations.index()
]
