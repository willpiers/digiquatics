@digiquatics.controller 'SubRequestsCtrl', ['$scope', 'SubRequests', 'Users',
                                            'Locations', 'Positions',
  @UsersCtrl = ($scope, SubRequests, Users, Locations, Positions) ->
    # Services
    $scope.subRequests = SubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'starts_at'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
