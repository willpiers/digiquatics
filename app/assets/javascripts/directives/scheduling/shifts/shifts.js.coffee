@digiquatics.directive 'dqShifts', [
  'ScheduleHelper'

  (ScheduleHelper) ->
    restrict: 'E'
    templateUrl: 'scheduling/shifts.html'
    scope:
      user: '='
      dayName: '='
      shifts: '='

    link: (scope, element, attrs) ->
      scope.days = ScheduleHelper.days

      scope.startEndTimes = ScheduleHelper.startEndTimes

      scope.open = (user, day, shift, size) ->
        modalInstance = $modal.open
          templateUrl: 'scheduling/shift-assigner.html'
          controller: 'ShiftModalCtrl as controller'
          size: size
          resolve:
            shift: -> shift
            data: =>
              user: user
              day: day
              location: buildLocation
              startTime: @$scope.weekDay(day).startOf('day').add 5, 'hours'
              endTime: @$scope.weekDay(day).startOf('day').add 10, 'hours'
              positions: $scope.positions
              position: user.position_id
]
