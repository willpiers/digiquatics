@digiquatics.controller 'ProcessedSubRequestsCtrl', ['$scope', 'ProcessedSubRequests', 'Users',
                                                     'Locations', 'Positions',
  @UsersCtrl = ($scope, ProcessedSubRequests, Users, Locations, Positions) ->
    # Services
    $scope.processedSubRequests = ProcessedSubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: '-processed_on'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.cssClass = (request) ->
      if request.approved == true then 'success'
      else 'danger'
]
