describe 'Availabilities', ->
  beforeEach inject (@ScheduleHelper, @$rootScope) ->
    @$scope = @$rootScope.$new()

    @$scope.day = 'Monday'
    @$scope.user =
      availabilities: [
        {}
      ]

    @html = "<dq-availabilities day-name='day' availabilities='user.availabilities'></dq-availabilities>"

  it 'does stuff', ->
    element = @$compile(@html) @$scope
    @$rootScope.$digest()
    $scope = element.isolateScope()

    # test for start-end time having a -
