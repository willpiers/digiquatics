describe 'UsersCtrl', ->
  scope = $httpBackend = undefined

  users = [
    id: 1
    first_name: 'Josh'
  ,
    id: 2
    first_name: 'Michael'
  ]

  beforeEach angular.mock.module('digiquatics')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/time_off_requests.json').respond []
    $httpBackend.expectGET('/users.json').respond users
    $httpBackend.expectGET('/locations.json').respond []
    $httpBackend.expectGET('/positions.json').respond []

    scope = $rootScope.$new()
    ctrl = $controller UsersCtrl,
      $scope: scope
  )

  it 'should set the users on scope', ->
    scope.users.length.should.equal 0

    $httpBackend.flush()

    scope.users.length.should.equal 2
