@digiquatics.controller 'SubRequestsCtrl', ['$scope', 'SubRequests', 'Users',
                                            'Locations', 'Positions', '$modal', '$log',
  @UsersCtrl = ($scope, SubRequests, Users, Locations, Positions, $modal, $log) ->
    # Services
    $scope.subRequests = SubRequests.index()
    $scope.locations = Locations.index()

    # Other
    $scope.predicate =
      value: 'shift.start_time'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.open = (shift, size) ->
      modalInstance = $modal.open(
        templateUrl: 'sub-request.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          shift: ->
            shift
        )

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, shift) ->
      $scope.requestSub = (shift) ->
        console.log "Shift" + if shift then shift.id
        console.log "User:" + shift.user_id
        SubRequests.create
          shift_id: shift.id
          user_id: shift.user_id

        console.log 'great success'
      $scope.ok = ->
        $scope.requestSub(shift)
        $modalInstance.close(shift)

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"
]
