@digiquatics.controller 'AvailabilityCtrl', ['$scope', '$filter','Availabilities',
                                            '$modal', '$log',
  @AvailabilityCtrl = ($scope, $filter, Availabilities, $modal, $log) ->
    $scope.days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ]

    $scope.availabilities = Availabilities.index()

    $scope.weekDay = (days) ->
      moment().startOf('week').add('days', days)

    $scope.startTime = (days) ->
      start = new Date()
      start.setDate($scope.weekDay(days).format('DD'))
      start.setHours 7
      start.setMinutes 0
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setDate($scope.weekDay(days).format('DD'))
      end.setHours 8
      end.setMinutes 0
      end

    $scope.open = (availability, day, size, availabilities, days) ->
      modalInstance = $modal.open(
        templateUrl: 'scheduling/availability/availability.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          day: ->
            day
          days: ->
            $scope.days
          availabilities: ->
            $scope.availabilities
          availability: ->
            availability
          startTime: ->
            $scope.startTime(day)
          endTime: ->
            $scope.endTime(day)
      )

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, day, availabilities, availability, startTime, endTime, days) ->
      $scope.day = day
      $scope.days = days
      $scope.availabilities = availabilities
      $scope.availability = availability
      $scope.startTime = if availability then availability.start_time else startTime
      $scope.endTime = if availability then availability.end_time else endTime

      assignAvailability = (availability, start, end, day, availabilities) ->
        if availability
          availability.start_time = start
          availability.end_time = end

          Availabilities.update
            id: availability.id
          ,
            availability
        else
          newAvailability = Availabilities.create
            day: day
            start_time: start
            end_time: end

          availabilities.push newAvailability

      $scope.ok = (startTime, endTime) ->
        assignAvailability availability, startTime, endTime, day, availabilities
        $modalInstance.close $scope.availability

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        Availabilities.destroy id: availability.id
        _.remove availabilities, (userAvail) -> userAvail.id is availability.id
        $modalInstance.close $scope.availability
]


