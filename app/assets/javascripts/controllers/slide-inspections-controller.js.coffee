@digiquatics.controller 'SlideInspectionsCtrl', ['$scope', 'SlideInspections',
                                                 'Locations'
  @SlideInspectionsCtrl = ($scope, SlideInspections, Locations) ->
    $scope.predicate =
      value: '-created_at'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (inspection) ->
      if      inspection.all_ok == false    then 'danger'
      else if     inspection.all_ok == true    then 'success'

    $scope.slideInspections = SlideInspections.index()

    $scope.locations = Locations.index()
]


