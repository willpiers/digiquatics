@digiquatics.controller 'ChemicalRecordsCtrl', ['$scope', 'ChemicalRecords',
                                                'Locations', 'Pools',
  @ChemicalRecordsCtrl = ($scope, ChemicalRecords, Locations, Pools) ->
    $scope.predicate =
      value: 'time_stamp'

    $scope.filters =
      location_id: ''
      pool_id: ''

    ChemicalRecords.index (data) ->
      $scope.chemicalRecords = data

    $scope.pools           = Pools.index()
    $scope.locations       = Locations.index()
]
