describe 'Time Off Requests', ->
  beforeEach inject (@ScheduleHelper, @$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    $scope.day = 'Thursday'
    $scope.user =
      time_off_requests: [
        dayIndices: [4]
        all_day: false
        starts_at: moment 'Thu Oct 09 2014 07:54:41 GMT-0600 (MDT)'
        ends_at: moment 'Thu Oct 09 2014 11:45:16 GMT-0600 (MDT)'
      ]

    html = "<dq-time-off-requests day-name='day' time-off-requests='user.time_off_requests'></dq-time-off-requests>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.isolateScope()

  it 'renders the time off request and formats the time correctly', ->
    @element.find('span').text().should.contain '7:54AM-11:45AM'
