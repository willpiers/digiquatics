@digiquatics.controller 'ChemicalRecordsCtrl', ['$scope', 'ChemicalRecords',
                                                'Locations', 'Pools',
  @ChemicalRecordsCtrl = ($scope, ChemicalRecords, Locations, Pools) ->
    $scope.predicate =
      value: '-time_stamp'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (record) ->
      if       record.si_index == null then ''
      else if  record.si_index < -0.6 then 'danger'
      else if  record.si_index >= -0.6 && record.si_index < -0.3 then 'warning'
      else if  record.si_index >= -0.3 && record.si_index <= 0.3 then 'success'
      else if  record.si_index > 0.3 && record.si_index < 0.6 then 'warning'
      else if  record.si_index > 0.6 then 'danger'
      else    'info'

    $scope.recordClassification = (record) ->
      if       record.si_index == null then ''
      else if  record.si_index < -0.6 then 'Danger'
      else if  record.si_index >= -0.6 && record.si_index < -0.3 then 'Warning'
      else if  record.si_index >= -0.3 && record.si_index <= 0.3 then 'Balanced'
      else if  record.si_index > 0.3 && record.si_index < 0.6 then 'Warning'
      else if  record.si_index > 0.6 then 'Danger SI Index > 0.6'
      else    'info'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.chemicalRecords = ChemicalRecords.index()

    $scope.pools = Pools.index()
    $scope.locations = Locations.index()
]
