describe 'Start Time', ->
  beforeEach inject (@$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    $scope.request =
      all_day: true
      starts_at: moment().startOf('day').add 1, 'hours'
      ends_at: moment().startOf('day').add 2, 'hours'
    $scope.data =
      start: moment().startOf('day').add 3, 'hours'
      end: moment().startOf('day').add 4, 'hours'

    html = "<dq-start-time request='request' data='data'></dq-start-time>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.scope()

  it 'passes the existing request times to the date picker via data object', ->
    @element.scope().request.all_day.should.equal true
    @element.scope().request.starts_at.format('h').should.equal '1'
    @element.scope().request.ends_at.format('h').should.equal '2'

