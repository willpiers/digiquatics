@digiquatics.controller 'SubRequestModalCtrl', [
  '$scope'
  '$modalInstance'
  'request'

  @SubRequestModalCtrl = ($scope, $modalInstance, request) ->
    $scope.location = request.shift.location.name
    $scope.position = request.shift.position.name
    $scope.shiftDate = moment(request.shift.start_time).format('M/DD/YY')
    $scope.shiftStartTime = moment(request.shift.start_time).format('h:mma')
    $scope.shiftEndTime = moment(request.shift.end_time).format('h:mma')
    $scope.requestedByFirstName = request.shift.user.first_name
    $scope.requestedByLastName = request.shift.user.last_name
    $scope.requestedOn = moment(request.created_at).format('M/DD/YY @ h:mma')

    $scope.requestSub = (request) ->
      SubRequests.create
        shift_id: shift.id
        user_id: shift.user_id
      console.log 'requested sub successfully'

    $scope.ok = ->
      $scope.requestSub(request)
      $modalInstance.close request

      toastr.success('Shift has been accepted!')
      return true #Fixes error with returns elements through Angular to the DOM

    $scope.cancel = ->
      $modalInstance.dismiss "Cancel"
]
