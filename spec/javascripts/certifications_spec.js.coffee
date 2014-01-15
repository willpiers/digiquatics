describe 'CertsCtrl', ->
  scope = $httpBackend = undefined

  certNames = ['CPR', 'LGI']
  users = [
    lastName: 'Last'
    firstName: 'First'
    LGI: '2014-03-07T17:00:00.000-07:00'
  ,
    lastName: 'Foo'
    firstName: 'Bar'
    CPR: '2014-02-08T17:00:00.000-07:00'
  ]

  beforeEach angular.mock.module('aquaticsApp')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/certification_expirations.json').respond
      certification_names: certNames
      users: users

    scope = $rootScope.$new()
    ctrl = $controller CertsCtrl,
      $scope: scope
  )

  it 'formatDate', ->
    expect(scope.formatDate('2014-03-07T17:00:00.000-07:00')).toBe '3/7/2014'

  it 'should set the cert names and users on scope', ->
    expect(scope.certNames).toEqual undefined
    expect(scope.users).toEqual undefined

    $httpBackend.flush()

    expect(scope.certNames).toEqual certNames
    expect(scope.users).toEqual users
