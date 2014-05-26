@digiquatics.controller 'SlideInspectionsCtrl', ['$scope', 'SlideInspections',
                                                 'Locations'
  @SlideInspectionsCtrl = ($scope, SlideInspections, Locations) ->
    $scope.predicate =
      value: '-created_at'

    $scope.cssClass = (inspection) ->
      if      inspection.all_ok == false    then 'danger'
      else if     inspection.all_ok == true    then 'success'

    $scope.slideInspections = SlideInspections.index()

    $scope.locations = Locations.index()
]


