@digiquatics.controller 'ChemicalRecordsCtrl', ['$scope', 'ChemicalRecords',
                                                'Locations', 'Pools',
  @ChemicalRecordsCtrl = ($scope, ChemicalRecords, Locations, Pools) ->
    $scope.predicate =
      value: 'time_stamp'

    $scope.locationFilter = ''

    ChemicalRecords.index (data) ->
      $scope.chemicalRecords = data

    $scope.pools           = Pools.index()
    $scope.locations       = Locations.index()
]
