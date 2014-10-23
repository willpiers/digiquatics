describe 'Shifts', ->
  beforeEach inject (@$rootScope, @$compile) ->
    @$scope = @$rootScope.$new()

  it 'needs to be implemented', ->
    true.should.be.false
