describe 'Availabilities', ->
  beforeEach inject (@ScheduleHelper, @$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    $scope.day = 'Monday'
    $scope.user =
      availabilities: [
        day: 1
        start_time: moment 'Thu Oct 09 2014 07:58:41 GMT-0600 (MDT)'
        end_time: moment 'Thu Oct 09 2014 11:59:16 GMT-0600 (MDT)'
      ]

    html = "<dq-availabilities day-name='day' availabilities='user.availabilities'></dq-availabilities>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.isolateScope()

  it 'renders the availability and formats the time correctly', ->
    @element.find('span').text().should.contain '7:58AM-11:59AM'
