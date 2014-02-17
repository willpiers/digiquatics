@digiquatics.controller 'ChemicalRecordsCtrl', ['$scope', 'ChemicalRecords',
                                                'Pools'
  @ChemicalRecordsCtrl = ($scope, ChemicalRecords, Pools) ->
    $scope.sorter =
      value: 'date_stamp'

    $scope.chemical_records = ChemicalRecords.index()
    $scope.pools = Pools.user_pools()
]
