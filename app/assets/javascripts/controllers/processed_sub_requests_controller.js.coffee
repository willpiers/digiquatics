@digiquatics.controller 'ProcessedSubRequestsCtrl', ['$scope', 'ProcessedSubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, ProcessedSubRequests, Users, Locations, Positions) ->
    # Services
    $scope.processedSubRequests = ProcessedSubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'starts_at'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (request) ->
      if request.approved == true then 'success'
      else 'danger'
]
