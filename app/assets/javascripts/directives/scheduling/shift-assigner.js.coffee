@digiquatics.directive 'dqShiftAssigner', ['Shifts',
  (Shifts) ->
    restrict: 'E'
    templateUrl: 'scheduling/shift-assign-button.html'
    scope:
      date: '='
      user: '='
      positions: '='
      location: '='
      startTime: '@'
      endTime: '@'

    link: (scope, element, attrs) ->
      element.find('.btn').bind 'click', ->

        Shifts.create
          user_id: scope.user.id
          location_id: scope.location
          position_id: scope.positionSelect
          start_time: scope.startTime
          end_time: scope.endTime

        console.log 'Shift was successfully created!'
]
