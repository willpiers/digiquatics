@digiquatics.controller 'ShiftReportsCtrl', ['$scope', 'ShiftReports',
                                             'Locations'
  @ShiftReportsCtrl = ($scope, ShiftReports, Locations) ->


      $scope.shiftReports = ShiftReports.index()

      $scope.locations       = Locations.index()
]
