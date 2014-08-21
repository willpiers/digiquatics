@digiquatics.controller 'AdminSubRequestsCtrl', ['$scope', 'AdminSubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, AdminSubRequests, Users, Locations, Positions) ->
    # Services
    $scope.adminSubRequests = AdminSubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'shift.start_time'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (request) ->
      if request.approved == true then 'success'
      else 'danger'
]
