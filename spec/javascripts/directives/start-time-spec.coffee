describe 'Start Time', ->
  beforeEach inject (@$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    # $scope.day = 'Thursday'
    $scope.request =
      all_day: true
      starts_at: moment()
      ends_at: moment()
    $scope.data =
      startTime: moment().startOf('day').add(7, 'hours').format 'YYYY-MM-DD'
      endTime: moment().startOf('day').add(8, 'hours').format 'YYYY-MM-DD'
      # user: $scope.data.user
      # location: $scope.data.location

    html = "<dq-start-time request='request' data='data'></dq-start-time>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.isolateScope()

  it 'renders the time picker with the right time', ->
