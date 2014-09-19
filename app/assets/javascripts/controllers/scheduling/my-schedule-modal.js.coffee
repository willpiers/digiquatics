@digiquatics.controller 'MyScheduleModalCtrl', [
  '$scope'
  '$modalInstance'
  'shift'

  @MyScheduleModalCtrl = ($scope, $modalInstance, shift) ->
    $scope.requestSub = (shift) ->
      SubRequests.create
        shift_id: shift.id
        user_id: shift.user_id
      console.log 'requested sub successfully'

    $scope.ok = ->
      $scope.requestSub(shift)
      $modalInstance.close shift

      toastr.success('Sub Request has been requested!')
      return true #Fixes error with returns elements through Angular to the DOM

    $scope.cancel = ->
      $modalInstance.dismiss "Cancel"
]
