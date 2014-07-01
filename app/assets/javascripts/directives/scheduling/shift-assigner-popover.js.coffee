@digiquatics.directive 'dqShiftAssignerPopover', ['$compile',
  ($compile) ->
    restrict: 'E'
    # templateUrl: 'scheduling/'
    template: '<a>popover</a>'
    scope:
      user: '='
      date: '@'
      positions: '='

    link: (scope, element, attrs) ->
      html = "<dq-shift-assigner date='date' user='user' positions='positions'></dq-shift-assigner>"

      element.children('a').popover
        html: true
        content: $compile(html) scope
]
