describe 'LocationsCtrl', ->
  scope = $httpBackend = undefined

  locations = [
    id: 1
    account_id: 1
    name: "Green Mountain Recreation Center"
    created_at: "2014-01-13T04:22:39.000-07:00"
    updated_at: "2014-01-13T04:22:39.000-07:00"
  ,
    id: 2
    account_id: 1
    name: "The Link Recreation Center"
    created_at: "2014-01-13T04:22:39.000-07:00"
    updated_at: "2014-01-13T04:22:39.000-07:00"
  ]

  users = [users: 'users!']

  beforeEach angular.mock.module('digiquatics')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/locations.json').respond locations
    $httpBackend.expectGET('/users.json').respond users

    scope = $rootScope.$new()
    ctrl = $controller LocationsCtrl,
      $scope: scope
  )

  it 'should set locations on scope', ->
    scope.locations.length.should.equal 0
    scope.users.length.should.equal 0

    $httpBackend.flush()

    scope.locations.length.should.equal 2
    scope.users.length.should.equal 1
