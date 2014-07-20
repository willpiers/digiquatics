@digiquatics.controller 'ProcessedSubRequestsCtrl', ['$scope', 'ProcessedSubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, ProcessedSubRequests, Users, Locations, Positions) ->
    # Services
    $scope.processedSubRequests = SubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
