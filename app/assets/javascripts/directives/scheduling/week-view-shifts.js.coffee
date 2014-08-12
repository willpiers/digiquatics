@digiquatics.directive 'dqWeekViewShifts', [
  '$modal'
  'Shifts'

  ($modal, Shifts) ->
    restrict: 'E'
    templateUrl: 'scheduling/week-view-shifts.html'
    scope:
      user: '='
      day: '='
      shift: '='
      weekCounter: '='

    link: ($scope, element, attrs) ->
      $scope.weekDay = (days) ->
        moment().startOf('week').add('days', $scope.weekCounter + days)

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

      $scope.open = (user, day, shift, size) ->
        modalInstance = $modal.open(
          templateUrl: 'scheduling/shift-assigner.html',
          controller: ModalInstanceCtrl,
          size: size,
          scope:
            user: user
          resolve:
            shift: ->
              shift
            user: ->
              user
            day: ->
              day
            location: ->
              $scope.buildLocation
            startTime: ->
              $scope.startTime(day)
            endTime: ->
              $scope.endTime(day)
            positions: ->
              $scope.positions
            position: ->
              user.position_id
          )

        modalInstance.result.then ->
          $log.info('Modal dismissed at: ' + new Date())

      ModalInstanceCtrl = ($scope, $modalInstance, shift, user, location, startTime, endTime, positions, position) ->
        $scope.user = user
        $scope.positions = positions
        $scope.positionSelect = if shift then shift.position_id else position
        $scope.startTime = if shift then shift.start_time else startTime
        $scope.endTime = if shift then shift.end_time else endTime

        $scope.assignShift = (user, location, position, start, end, shift) ->
          if shift
            $id = shift.id
            shift.start_time = start
            shift.end_time = end
            shift.position_id = position
            Shifts.update({ id:$id }, shift)
          else Shifts.create
            user_id: user.id
            location_id: location
            position_id: position
            start_time: start
            end_time: end

        $scope.ok = (position, startTime, endTime) ->
          $scope.assignShift(user, location, position, startTime, endTime, shift)
          $modalInstance.close($scope.user)

        $scope.cancel = ->
          $modalInstance.dismiss "Cancel"

        $scope.delete = ->
          Shifts.destroy({ id: shift.id })
          element.remove()
          $modalInstance.close($scope.user)

]
