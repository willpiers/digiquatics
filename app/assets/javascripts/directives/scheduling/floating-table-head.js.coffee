@digiquatics.directive 'dqFloatingTableHead', [
  'ScheduleHelper'
  '$window'

  (ScheduleHelper, $window) ->
    restrict: 'E'
    templateUrl: 'scheduling/floating-table-head.html'
    scope:
      days: '='

    link: (scope, element, attrs) ->
      scope.weekDay = _.bind ScheduleHelper.weekDay, ScheduleHelper

      scope.fixHead = false

      checkAndToggleFixHead = (value) ->
        if scope.fixHead isnt value
          scope.fixHead = value
          scope.$apply()

      angular.element($window).bind 'scroll', ->
        checkAndToggleFixHead @.pageYOffset > 400
]
