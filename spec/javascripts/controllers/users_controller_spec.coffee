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

    $httpBackend.expectGET('/users.json').respond users

    scope = $rootScope.$new()
    ctrl = $controller UsersCtrl,
      $scope: scope
  )

  it 'should set the users on scope', ->
    expect(scope.users).toEqualData []

    $httpBackend.flush()

    expect(scope.users).toEqualData users
