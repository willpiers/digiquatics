describe 'Availabilities', ->
  beforeEach inject (@ScheduleHelper, @$rootScope, @$compile) ->
    @$scope = @$rootScope.$new()

    @$scope.day = moment().format 'dddd'
    @$scope.user =
      availabilities: [
        day: moment().add(1, 'day').day()
        start_time: moment().startOf('day').add 5, 'hours'
        end_time: moment().startOf('day').add 10, 'hours'
      ]

    html = "<dq-availabilities day-name='day' availabilities='user.availabilities'></dq-availabilities>"

    @element = @$compile(html) @$scope
    @$rootScope.$digest()
    scope = @element.isolateScope()

  it 'renders the availability and formats the time correctly', ->
    startsAt = moment(@$scope.user.availabilities[0].start_time).format('h:mmA')
    endsAt = moment(@$scope.user.availabilities[0].end_time).format('h:mmA')
    @element.find('span').text().should.contain "#{startsAt}-#{endsAt}"
