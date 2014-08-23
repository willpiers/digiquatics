@digiquatics.controller 'AvailabilityCtrl', [
  '$scope'
  '$filter'
  'Availabilities'
  '$modal'
  '$log'

  @AvailabilityCtrl = ($scope, $filter, Availabilities, $modal, $log) ->
    $scope.days = [
      'Sunday'
      'Monday'
      'Tuesday'
      'Wednesday'
      'Thursday'
      'Friday'
      'Saturday'
    ]

    $scope.availabilities = Availabilities.index()

    $scope.sortTime = (availability) ->
      momentTime = moment availability.start_time
      momentTime - momentTime.clone().startOf 'day'

    weekDay = (days) ->
      moment().startOf('week').add('days', days)

    $scope.startTime = (days) ->
      start = new Date()
      start.setDate(weekDay(days).format('DD'))
      start.setHours 7
      start.setMinutes 0
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setDate(weekDay(days).format('DD'))
      end.setHours 8
      end.setMinutes 0
      end

    $scope.open = (availability, day, size) ->
      modalInstance = $modal.open
        templateUrl: 'scheduling/availability/availability.html'
        controller: ModalInstanceCtrl
        size: size
        scope: $scope
        resolve:
          day: -> day
          availability: -> availability

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, day, availability) ->
      angular.extend $scope,
        day: day
        availability: availability
        startTime: if availability then availability.start_time else $scope.startTime(day)
        endTime: if availability then availability.end_time else $scope.endTime(day)

      $scope.ok = (startTime, endTime) ->
        if availability
          availability.start_time = startTime
          availability.end_time = endTime
          availability.$save()
        else
          newAvailability = Availabilities.create
            day: day
            start_time: startTime
            end_time: endTime

          $scope.availabilities.push newAvailability

        $modalInstance.close $scope.availability

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        Availabilities.destroy id: availability.id
        _.remove $scope.availabilities, (userAvail) -> userAvail.id is availability.id

        $modalInstance.close $scope.availability

    ModalInstanceCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'day'
      'availability'
    ]
]
