@digiquatics.controller 'AvailabilityCtrl', [
  '$scope'
  '$filter'
  'Availabilities'
  '$modal'
  '$log'
  'ScheduleHelper'

  @AvailabilityCtrl = ($scope, $filter, Availabilities, $modal,
                       $log, ScheduleHelper) ->
    angular.extend $scope, ScheduleHelper

    $scope.availabilities = Availabilities.index()

    $scope.sortTime = (availability) ->
      momentTime = moment availability.start_time
      momentTime - momentTime.clone().startOf 'day'

    weekDay = (days) ->
      moment().startOf('week').add days, 'days'

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

    $scope.open = (day, availability, size) ->
      modalInstance = $modal.open
        templateUrl: 'availabilities/availability.html'
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
          availability.$update()
          .then ->
            $modalInstance.close $scope.availability
            toastr.info 'Availability was successfully updated.'
        else
          newAvailability = Availabilities.create
            day: day
            start_time: startTime
            end_time: endTime
          .$promise.then (newAvailability) ->
            $modalInstance.close $scope.availability
            $scope.availabilities.push newAvailability
            toastr.success 'Availability was successfully created.'

      $scope.cancel = ->
        $modalInstance.dismiss "Cancel"

      $scope.delete = ->
        availability.$destroy().then ->
          $modalInstance.close $scope.availability
          _.remove $scope.availabilities, id: availability.id
          toastr.error 'Availability was successfully deleted.'

    ModalInstanceCtrl['$inject'] = [
      '$scope'
      '$modalInstance'
      'day'
      'availability'
    ]
]
