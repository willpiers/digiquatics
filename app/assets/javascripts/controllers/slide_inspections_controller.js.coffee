@digiquatics.controller 'SlideInspectionsCtrl', ['$scope', 'SlideInspections',
  @SlideInspectionsCtrl = ($scope, SlideInspections) ->
    $scope.predicate =
      value: '-created_at'

    $scope.slideInspections = SlideInspections.index()
]


