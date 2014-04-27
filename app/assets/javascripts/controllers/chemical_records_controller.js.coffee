@digiquatics.controller 'ChemicalRecordsCtrl', ['$scope', 'ChemicalRecords',
                                                'Locations', 'Pools',
  @ChemicalRecordsCtrl = ($scope, ChemicalRecords, Locations, Pools) ->
    $scope.predicate =
      value: 'time_stamp'

    $scope.filters =
      location_id: ''
      pool_id: ''

    $scope.totalDisplayed = 20

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    ChemicalRecords.index (data) ->
      $scope.chemicalRecords = data

    $scope.pools           = Pools.index()
    $scope.locations       = Locations.index()
]
