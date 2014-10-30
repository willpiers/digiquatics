@digiquatics.controller 'SubRequestsCtrl', [
  '$scope'
  'SubRequests'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  '$log'

  @SubRequestsCtrl = ($scope, SubRequests, Users, Locations, Positions, $modal,
                      $log) ->
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

    $scope.approveButton = (current_user, request) ->
      angular.extend current_user, request

      updatedRequestData =
        approved: true
        processed: true
        processed_on: moment()
        processed_by_user_id: current_user.id
        processed_by_first_name: current_user.first_name
        processed_by_last_name: current_user.last_name

      SubRequests.update id: $scope.request.id, updatedRequestData
      .$promise.then (updatedRequestData) ->
        $scope.subRequests.push updatedRequestData
        toastr.success('Employee Sub Request has been approved.')

    $scope.denyButton = (current_user, request) ->
      angular.extend current_user, request

      updatedRequestData =
        approved: false
        processed: true
        processed_on: moment()
        processed_by_user_id: current_user.id
        processed_by_first_name: current_user.first_name
        processed_by_last_name: current_user.last_name

      SubRequests.update id: $scope.request.id, updatedRequestData
      .$promise.then (updatedRequestData) ->
        $scope.subRequests.push updatedRequestData
        toastr.error('Employee Sub Request has been denied.')

    $scope.open = (request, size) ->
      modalInstance = $modal.open
        templateUrl: 'scheduling/sub-requests/accept-sub-request.html',
        controller: SubRequestModalCtrl,
        size: size,
        resolve:
          request: -> request
          userIsAdmin: -> $scope.userIsAdmin
          subUserId: -> $scope.subUserId
          subUserFirstName: -> $scope.subUserFirstName
          subUserLastName: -> $scope.subUserLastName
          subRequests: -> $scope.subRequests

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    SubRequestModalCtrl = ($scope, $modalInstance, request, userIsAdmin,
                           subUserId, subUserFirstName, subUserLastName,
                           SubRequests, subRequests) ->
      $scope.request = request
      $scope.location = request.shift.location.name
      $scope.position = request.shift.position.name
      $scope.shiftDate = moment(request.shift.start_time).format('M/DD/YY')
      $scope.shiftStartTime = moment(request.shift.start_time).format('h:mma')
      $scope.shiftEndTime = moment(request.shift.end_time).format('h:mma')
      $scope.requestedByFirstName = request.shift.user.first_name
      $scope.requestedByLastName = request.shift.user.last_name
      $scope.requestedOn = moment(request.created_at).format('M/DD/YY @ h:mma')
      $scope.subUserId = subUserId
      $scope.subUserFirstName = subUserFirstName
      $scope.subUserLastName = subUserLastName

      $scope.correctUser = (request, subUserId) ->
        userIsAdmin or request.user_id is subUserId

      acceptShift = (request, subUserId, subUserFirstName, subUserLastName) ->
        requestData = angular.extend request,
          active: false
          sub_user_id: $scope.subUserId
          sub_first_name: $scope.subUserFirstName
          sub_last_name: $scope.subUserLastName

        SubRequests.update id: requestData.id, requestData
        .$promise.then (updatedSubRequest) ->
          _.remove subRequests, (subRequest) -> subRequest.id is request.id
          subRequests.push updatedSubRequest
          $modalInstance.close updatedSubRequest
          toastr.success('Shift has been accepted!')

      $scope.ok = ->
        acceptShift(request)

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        SubRequests.destroy id: request.id
        _.remove subRequests, (subRequest) -> subRequest.id is request.id
        $modalInstance.close $scope.user
        toastr.error('Sub Request was successfully deleted.')
        return true #Fixes error with returns elements through Angular to the DOM

    SubRequestModalCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'request'
      'userIsAdmin'
      'subUserId'
      'subUserFirstName'
      'subUserLastName'
      'SubRequests'
      'subRequests'
    ]
]
