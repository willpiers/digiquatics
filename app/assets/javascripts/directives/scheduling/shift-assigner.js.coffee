@digiquatics.directive 'dqShiftAssigner', [
  ->
    restrict: 'E'
    templateUrl: 'scheduling/shift-assigner.html'
    scope:
      date: '='
      user: '='

    link: (scope, element, attrs) ->
]
