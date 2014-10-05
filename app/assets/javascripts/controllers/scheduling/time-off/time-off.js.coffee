@digiquatics.controller 'TimeOffCtrl', [
  '$scope'
  'TimeOff'
  'Users'
  'Locations'
  'Positions'
  '$modal'
  'TimeOffHelper'
  '$log'

  @TimeOffCtrl = ($scope, TimeOff, Users, Locations, Positions, $modal, TimeOffHelper, $log) ->
    angular.extend $scope, TimeOffHelper
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    $scope.requestMode = 'partialDay'

    $scope.allDayRequestMode = ->
      $scope.requestMode is 'allDay'

    $scope.partialDayRequestMode = ->
      $scope.requestMode is 'partialDay'

    $scope.today1 = ->
      $scope.dt1 = moment().format('YYYY-MM-DD')

    $scope.today2 = ->
      $scope.dt2 = moment().format('YYYY-MM-DD')

    $scope.today1()
    $scope.today2()

    $scope.open1 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened1 = true

    $scope.open2 = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.opened2 = true

    $scope.dateOptions =
      "year-format": "'yy'"
      "starting-day": 1

    $scope.setPartial1 = ->
      $scope.partialDayStartTime = moment().startOf('day').add 7, 'hours'

    $scope.setPartial2 = ->
      $scope.partialDayEndTime = moment().startOf('day').add 8, 'hours'

    $scope.setAll1 = ->
      $scope.allDayStartTime = moment().startOf('day').add 1, 'minutes'

    $scope.setAll2 = ->
      $scope.allDayEndTime = moment().startOf('day').add(23, 'hours').add(59, 'minutes')

    $scope.setPartial1()
    $scope.setPartial2()
    $scope.setAll1()
    $scope.setAll2()

    $scope.hstep = 1

    $scope.ismeridian = true

    $scope.changed = ->
      console.log "Time changed to: " + $scope.mytime

    $scope.predicate =
      value: 'last_name'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.open = (request, user) ->
      modalInstance = $modal.open
        templateUrl: 'scheduling/time_off_requests/time-off-request.html',
        controller: TimeOffRequestModalCtrl,
        resolve:
          request: -> request
          timeOff: -> $scope.timeOff
          timeOffUserId: -> $scope.timeOffUserId
          timeOffUserFirstName: -> $scope.timeOffUserFirstName
          timeOffUserLastName: -> $scope.timeOffUserLastName

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    TimeOffRequestModalCtrl = ($scope, $modalInstance, request, TimeOff,
                               timeOff, TimeOffHelper, timeOffUserId,
                               timeOffUserFirstName, timeOffUserLastName) ->
      angular.extend $scope, TimeOffHelper
      $scope.request = request
      $scope.location = request.location.name
      $scope.user = request.user
      $scope.timeOffUserId = timeOffUserId
      $scope.timeOffUserFirstName = timeOffUserFirstName
      $scope.timeOffUserLastName = timeOffUserLastName

      $scope.approveRequest = (request) ->
        console.log request
        requestData = angular.extend request,
          approved: true
          active: false
          time_off_user_id: $scope.timeOffUserId
          time_off_first_name: $scope.timeOffUserFirstName
          time_off_last_name: $scope.timeOffUserLastName
          approved_at: moment()

        TimeOff.update id: requestData.id, requestData
        .$promise.then (updatedRequest) ->
          _.remove timeOff, (timeOffRequest) -> timeOffRequest.id is request.id
          timeOff.push updatedRequest

      $scope.denyRequest = (request) ->
        requestData = angular.extend request,
          approved: false
          active: false
          time_off_user_id: $scope.timeOffUserId
          time_off_first_name: $scope.timeOffUserFirstName
          time_off_last_name: $scope.timeOffUserLastName
          approved_at: moment()

        TimeOff.update id: requestData.id, requestData
        .$promise.then (updatedRequest) ->
          _.remove timeOff, (timeOffRequest) -> timeOffRequest.id is request.id
          timeOff.push updatedRequest

      $scope.approve = ->
        $scope.approveRequest(request)
        $modalInstance.close request

        toastr.success('Time Off Request has been approved.')
        true

      $scope.deny = ->
        $scope.denyRequest(request)
        $modalInstance.close request

        toastr.error('Time Off Request has been denied.')
        true

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        TimeOff.destroy id: request.id
        _.remove timeOff, (timeOff) -> timeOff.id is request.id
        $modalInstance.close $scope.user

        toastr.error('Time Off Request was successfully deleted.')
        true

      TimeOffRequestModalCtrl['$inject'] = [
        '$scope'
        '$modalInstance'
        'request'
        'TimeOff'
        'timeOff'
        'TimeOffHelper'
        'timeOffUserId'
        'timeOffUserFirstName'
        'timeOffUserLastName'
      ]

]
