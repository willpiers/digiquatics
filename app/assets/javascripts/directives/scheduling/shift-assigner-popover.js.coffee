@digiquatics.directive 'dqShiftAssignerPopover', ['$compile',
  ($compile) ->
    restrict: 'E'
    # templateUrl: 'scheduling/'
    template: '<a>popover</a>'
    scope:
      user: '='
      date: '@'

    link: (scope, element, attrs) ->
      element.children('a').popover
        html: true
        content: $compile("<dq-shift-assigner date='date' user='user' position='position'></dq-shift-assigner>")(scope)
]
