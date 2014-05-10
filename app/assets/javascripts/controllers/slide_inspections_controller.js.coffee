@digiquatics.controller 'SlideInspectionsCtrl', ['$scope', 'SlideInspections',
  @SlideInspectionsCtrl = ($scope, SlideInspections) ->
    $scope.predicate =
      value: '-created_at'

    $scope.cssClass = (inspection) ->
      if      inspection.all_ok == false    then 'danger'
      else if     inspection.all_ok == true    then 'success'

    $scope.slideInspections = SlideInspections.index()
]


