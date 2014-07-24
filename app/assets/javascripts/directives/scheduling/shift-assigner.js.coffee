@digiquatics.directive 'dqShiftAssigner', ['Shifts',
  (Shifts) ->
    restrict: 'E'
    templateUrl: 'scheduling/shift-assigner.html'
    scope:
      date: '='
      user: '='
      positions: '='
      location: '='

    link: (scope, element, attrs) ->
      element.find('.btn').bind 'click', ->
        Shifts.create
          user_id: scope.user.id
          location_id: scope.location
          position_id: positionSelect
          start_time: scope.startTime
          end_time: scope.endTime

        console.log 'Shift was successfully created!'
]
