describe 'Start Time', ->
  beforeEach inject (@$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    $scope.request =
      all_day: true
      starts_at: moment().format 'h:mma'
      ends_at: moment().add(1, 'hours').format 'h:mma'
    $scope.data =
      start: moment().startOf('day').add(7, 'hours').format 'h:mma'
      end: moment().startOf('day').add(8, 'hours').format 'h:mma'

    html = "<dq-start-time request='request' data='data'></dq-start-time>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.scope()

  it 'passes the data to the time picker', ->
    @element.scope().data.start.should.equal moment().startOf('day').add(7, 'hours').format 'h:mma'
    @element.scope().data.end.should.equal moment().startOf('day').add(8, 'hours').format 'h:mma'
    @element.scope().request.all_day.should.equal true
    @element.scope().request.starts_at.should.equal moment().format 'h:mma'
    @element.scope().request.ends_at.should.equal moment().add(1, 'hours').format 'h:mma'

