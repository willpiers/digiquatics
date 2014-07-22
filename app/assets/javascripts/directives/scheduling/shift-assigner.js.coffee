@digiquatics.directive 'dqShiftAssigner', ['Shifts',
  (Shifts) ->
    restrict: 'E'
    templateUrl: 'scheduling/shift-assigner.html'
    scope:
      date: '='
      user: '='
      positions: '='

    link: (scope, element, attrs) ->
      element.find('.btn').bind 'click', ->
        Shifts.create
          user_id: scope.user.id
          location_id: 2
          position_id: 3
          start_time: scope.startTime
          end_time: scope.endTime

        # console.log 'hi'
        # console.log 'user_id: <user_id>'
        # console.log 'location_id: <location_id>'
        # console.log 'position_id: <position_id>'
        # console.log 'start_time: <start_time>'
        # console.log 'end_time: <end_time>'
        console.log 'Shift was successfully created!'
]
