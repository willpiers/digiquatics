describe 'User Info', ->
  beforeEach inject (@$rootScope, @$compile) ->
    $scope = @$rootScope.$new()

    $scope.user =
      last_name: 'Duffy'
      first_name: 'Josh'
      weeklyHours: 14

    html = "<dq-user-info user='user'></dq-user-info>"

    @element = @$compile(html) $scope
    @$rootScope.$digest()
    scope = @element.isolateScope()

  it 'renders the user including last name', ->
    @element.find('span').text().should.contain 'Duffy'
    @element.find('span').text().should.contain 'Josh'
    @element.find('span').text().should.contain '14'


