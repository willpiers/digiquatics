@digiquatics.controller 'TimeOffCtrl', [
  '$scope'
  'TimeOff'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  'TimeOffHelper'

  @TimeOffCtrl = ($scope, TimeOff, Users, Locations, Positions, $modal, TimeOffHelper) ->
    angular.extend $scope, TimeOffHelper
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.predicate =
      value: '-created_at'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.cssClass = (request) ->
      if request.approved and !request.active then 'success'
      else if !request.approved and !request.active then 'danger'
      else 'warning'

    $scope.checkActive = (request) ->
      request.active

    $scope.open = (editMode, request) ->
      modalInstance = $modal.open
        templateUrl: 'scheduling/time-off/time-off-request-modal.html',
        controller: TimeOffRequestModalCtrl,
        scope: $scope
        resolve:
          request: -> request
          editMode: -> editMode
          data: ->
            startTime: moment().startOf('day').add 7, 'hours'
            endTime: moment().startOf('day').add 8, 'hours'
            user: $scope.data.user
            location: $scope.data.location

    TimeOffRequestModalCtrl = ($scope, $modalInstance, request, editMode, TimeOff,
                               TimeOffHelper, data) ->
      angular.extend $scope, TimeOffHelper
      $scope.state = {}
      $scope.state.allDayRequest = false
      $scope.request = request
      $scope.data =
        start: data.startTime
        end: data.endTime
        user: data.user
        location: data.location
        reason: $scope.request?.reason

      $scope.editMode = editMode

      $scope.setTimesPartialDay = ->
        $scope.data.start = data.startTime
        $scope.data.end = data.endTime

      $scope.setTimesAllDay = ->
        $scope.data.start = moment().startOf('day').add 1, 'minutes'
        $scope.data.end = moment().startOf('day').add(23, 'hours').add 59, 'minutes'

      $scope.setAllDayLogic = ->
        if request and request.all_day
          $scope.state.allDayRequest = true
          $scope.setTimesAllDay()
        if request and !request.all_day
          $scope.state.allDayRequest = false
        else
          $scope.setTimesPartialDay()

      $scope.setAllDayLogic()

      $scope.ok = ->
        assignRequest(request).then ->
          $modalInstance.close request

      assignRequest = (request) ->
        if request
          updateExistingRequest request
        else
          createNewRequest()

      updateExistingRequest = (request) ->
        requestData = angular.extend request,
          starts_at: $scope.data.start
          ends_at: $scope.data.end
          all_day: $scope.state.allDayRequest
          reason: $scope.data.reason

        TimeOff.update id: requestData.id, requestData
        .$promise.then (updatedRequest) ->
          _.remove $scope.timeOff, (timeOffRequest) -> timeOffRequest is request.id
          $scope.timeOff.push updatedRequest
          toastr.success 'Time Off Request has been updated.'

      createNewRequest = ->
        TimeOff.create
          user_id: $scope.data.user.id
          location_id: $scope.data.location.id
          starts_at: $scope.data.start
          ends_at: $scope.data.end
          all_day: $scope.state.allDayRequest
          reason: $scope.data.reason

        .$promise.then (newRequest) ->
          $scope.timeOff.push newRequest
          toastr.success 'Time Off Request has been created.'


      $scope.approve = ->
        approveRequest(request).then ->
          $modalInstance.close request
          toastr.success 'Time Off Request has been approved.'

      approveRequest = (request) ->
        requestData = angular.extend request,
          approved: true
          active: false
          approved_by_user_id: $scope.data.user.id
          processed_by_first_name: $scope.data.user.first_name
          processed_by_last_name: $scope.data.user.last_name
          approved_at: moment()

        TimeOff.update id: requestData.id, requestData
        .$promise.then (updatedRequest) ->
          _.remove $scope.timeOff, id: request.id

      $scope.deny = ->
        denyRequest(request).then ->
          $modalInstance.close request
          toastr.error 'Time Off Request has been denied.'

      denyRequest = (request) ->
        requestData = angular.extend request,
          approved: false
          active: false
          approved_by_user_id: $scope.data.user.id
          processed_by_first_name: $scope.data.user.first_name
          processed_by_last_name: $scope.data.user.last_name
          approved_at: moment()

        TimeOff.update id: requestData.id, requestData
        .$promise.then (updatedRequest) ->
          _.remove $scope.timeOff, id: request.id

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        TimeOff.destroy id: request.id
        .$promise.then ->
          _.remove $scope.timeOff, id: request.id
          $modalInstance.close $scope.user
          toastr.error 'Time Off Request was successfully deleted.'

      TimeOffRequestModalCtrl['$inject'] = [
        '$scope'
        '$modalInstance'
        'request'
        'editMode'
        'TimeOff'
        'TimeOffHelper'
        'data'
      ]
]
