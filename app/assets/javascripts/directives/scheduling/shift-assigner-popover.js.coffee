@digiquatics.directive 'dqShiftAssignerPopover', ['$compile',
  ($compile) ->
    restrict: 'E'
    template: '<a>Create Shift</a>'
    scope:
      user: '='
      date: '@'
      positions: '='
      location: '@'

    link: (scope, element, attrs) ->
      html = "<dq-shift-assigner date='date' user='user' positions='positions' location='location'></dq-shift-assigner>"

      element.children('a').popover
        html: true
        content: $compile(html) scope
]
