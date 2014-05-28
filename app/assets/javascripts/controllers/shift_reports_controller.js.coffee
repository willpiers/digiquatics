@digiquatics.controller 'ShiftReportsCtrl', ['$scope', 'ShiftReports',
                                             'Locations'
  @ShiftReportsCtrl = ($scope, ShiftReports, Locations) ->

    $scope.predicate =
      value: '-created_at'

    $scope.cssClass = (report) ->
      if      report.report_filed == 'Yes'    then 'success'
      else    'danger'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.shiftReports = ShiftReports.index()

    $scope.locations       = Locations.index()
]
