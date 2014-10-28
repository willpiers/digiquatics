describe 'Shifts', ->
  beforeEach inject (@$rootScope, @$compile) ->
    @$scope = @$rootScope.$new()

    @$scope.day = moment().format 'dddd'

    @$scope.user =
      shifts: [
        dayIndex: [moment().weekday()]
        position: name: 'MOD'
        start_time: moment().startOf('day').add 5, 'hours'
        end_time: moment().startOf('day').add 10, 'hours'
      ]

    @html = "<dq-shifts day-name='day' shifts='user.shifts'
              user-is-admin='state.userIsAdmin'
              open='open(user, days.indexOf(day), shift)'>
             </dq-shifts>"

  it 'renders the shift correctly', ->
    @element = @$compile(@html) @$scope
    @$rootScope.$digest()
    startsAt = moment(@$scope.user.shifts[0].start_time).format('h:mmA')
    endsAt = moment(@$scope.user.shifts[0].end_time).format('h:mmA')
    @element.find('span').text().should.contain "#{startsAt}-#{endsAt}"
    @element.find('span').text().should.contain 'MOD'
