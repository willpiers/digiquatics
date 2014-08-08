@digiquatics.controller 'AvailabilityCtrl', ['$scope', '$filter','Availabilities',
                                            '$modal', '$log',
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

    $scope.weekDay = (days) ->
      moment().startOf('week').add('days', days)

    $scope.startTime = (days) ->
      start = new Date()
      start.setDate($scope.weekDay(days).format('DD'))
      start.setHours(7)
      start.setMinutes(0)
      start

    $scope.endTime = (days) ->
      end = new Date()
      end.setDate($scope.weekDay(days).format('DD'))
      end.setHours(8)
      end.setMinutes(0)
      end

    $scope.open = (day, availability, size) ->
      modalInstance = $modal.open(
        templateUrl: 'scheduling/availability/availability.html',
        controller: ModalInstanceCtrl,
        size: size,
        resolve:
          day: ->
            day
          availability: ->
            availability
          startTime: ->
            $scope.startTime(day)
          endTime: ->
            $scope.endTime(day)
      )

      modalInstance.result.then ->
        $log.info('Modal dismissed at: ' + new Date())

    ModalInstanceCtrl = ($scope, $modalInstance, day, availability, startTime, endTime) ->
      $scope.day = day
      $scope.availability = availability
      $scope.startTime = if availability then availability.start_time else startTime
      $scope.endTime = if availability then availability.end_time else endTime

      $scope.assignAvailability = (availability, start, end, day) ->
        if availability
          $id = availability.id
          availability.day = day
          availability.start_time = start
          availability.end_time = end
          Availabilities.update({ id:$id }, availability)
        else Availabilities.create
          day: day
          start_time: start
          end_time: end

      $scope.deleteAvailability = (availability) ->
        $id = availability.id
        Availabilities.destroy({ id:$id })

      $scope.ok = (startTime, endTime) ->
        $scope.assignAvailability(availability, startTime, endTime, day)
        $modalInstance.close($scope.availability)

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        $scope.deleteAvailability(availability)
        $modalInstance.close($scope.availability)
]


