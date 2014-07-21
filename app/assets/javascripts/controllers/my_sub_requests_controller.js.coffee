@digiquatics.controller 'MySubRequestsCtrl', ['$scope', 'MySubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, MySubRequests, Users, Locations, Positions) ->
    # Services
    $scope.mySubRequests = MySubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (request) ->
      if request.approved == true then 'success'
      else 'danger'
]
