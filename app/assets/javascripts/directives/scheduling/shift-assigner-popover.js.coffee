@digiquatics.directive 'dqShiftAssignerPopover', ['$compile',
  ($compile) ->
    restrict: 'E'
    template: '<a>Create Shift</a>'
    scope:
      user: '='
      date: '@'
      positions: '='
      location: '@'
      startTime: '='
      endTime: '='

    link: (scope, element, attrs) ->
      html = "<dq-shift-assigner
                user='user' date='date' positions='positions'
                location='location'
                startTime='startTime' endTime='endTime'
                >
              </dq-shift-assigner>"

      element.children('a').popover
        html: true
        content: $compile(html) scope
]
