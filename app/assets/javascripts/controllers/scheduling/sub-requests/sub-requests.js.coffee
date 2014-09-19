@digiquatics.controller 'SubRequestsCtrl', ['$scope', 'SubRequests', 'Users',
                                            'Locations', 'Positions', '$modal', '$log',
  @UsersCtrl = ($scope, SubRequests, Users, Locations, Positions, $modal, $log) ->
    # Services
    $scope.subRequests = SubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'shift.start_time'

    $scope.days = [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.open = (request, size) ->
      modalInstance = $modal.open
        templateUrl: 'accept-sub-request.html',
        controller: SubRequestModalCtrl,
        size: size,
        resolve:
          request: -> request

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())
]
