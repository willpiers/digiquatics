@digiquatics.controller 'SubRequestsCtrl', [
  '$scope'
  'SubRequests'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  '$log'
  @SubRequestsCtrl = ($scope, SubRequests, Users, Locations, Positions, $modal, $log) ->
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

    $scope.open = (shift, size) ->
      modalInstance = $modal.open
        templateUrl: 'sub-request.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          shift: -> shift

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, shift) ->
      $scope.requestSub = (shift) ->
        SubRequests.create
          shift_id: shift.id
          user_id: shift.user_id

      $scope.ok = ->
        $scope.requestSub(shift)
        $modalInstance.close(shift)

        toastr.success('Sub Request has been requested!')
        return true #Fixes error with returns elements through Angular to the DOM

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

    ModalInstanceCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'shift'
    ]
]
