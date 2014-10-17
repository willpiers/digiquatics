describe 'Time Off Requests', ->
  beforeEach inject (@ScheduleHelper, @$rootScope, @$compile) ->
    @$scope = @$rootScope.$new()

    @$scope.day = 'Thursday'
    @$scope.user =
      time_off_requests: [
        dayIndices: [4]
        starts_at: moment 'Thu Oct 09 2014 07:54:41 GMT-0600 (MDT)'
        ends_at: moment 'Thu Oct 09 2014 11:45:16 GMT-0600 (MDT)'
      ]

    @html = "<dq-time-off-requests day-name='day' time-off-requests='user.time_off_requests'></dq-time-off-requests>"

  it 'renders the partial day time off request and formats correctly', ->
    @$scope.user.time_off_requests[0].all_day = false
    @element = @$compile(@html) @$scope
    @$rootScope.$digest()
    @element.find('span').text().should.contain '7:54AM-11:45AM'

  it 'renders the all day time off request and formats the time correctly', ->
    @$scope.user.time_off_requests[0].all_day = true
    @element = @$compile(@html) @$scope
    @$rootScope.$digest()
    @element.find('span').text().should.contain 'Time Off'
