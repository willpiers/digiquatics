describe 'Time Off Requests', ->
  beforeEach inject (@ScheduleHelper, @$rootScope, @$compile) ->
    @$scope = @$rootScope.$new()

    @$scope.day = moment().format 'dddd'
    @$scope.user =
      time_off_requests: [
        dayIndices: [moment().weekday()]
        starts_at: moment().startOf('day').add(5, 'hours')
        ends_at: moment().startOf('day').add(10, 'hours')
      ]

    @html = "<dq-time-off-requests day-name='day' time-off-requests='user.time_off_requests'></dq-time-off-requests>"

  it 'renders the partial day time off request and formats correctly', ->
    @$scope.user.time_off_requests[0].all_day = false
    @element = @$compile(@html) @$scope
    @$rootScope.$digest()
    startsAt = moment(@$scope.user.time_off_requests[0].starts_at).format('h:mmA')
    endsAt = moment(@$scope.user.time_off_requests[0].ends_at).format('h:mmA')

    @element.find('span').text().should.contain "#{startsAt}-#{endsAt}"

  it 'renders the all day time off request and formats the time correctly', ->
    @$scope.user.time_off_requests[0].all_day = true
    @element = @$compile(@html) @$scope
    @$rootScope.$digest()
    @element.find('span').text().should.contain 'Time Off'
