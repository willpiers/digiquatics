describe 'CertificationsCtrl', ->
  scope = $httpBackend = undefined

  certificationNames = ['CPR', 'LGI']
  users = [
    lastName: 'Last'
    firstName: 'First'
    LGI: '2014-03-07T17:00:00.000-07:00'
  ,
    lastName: 'Foo'
    firstName: 'Bar'
    CPR: '2014-02-08T17:00:00.000-07:00'
  ]

  beforeEach angular.mock.module('digiquatics')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/certification_expirations.json').respond
      certification_names: certificationNames
      users: users

    scope = $rootScope.$new()
    ctrl = $controller CertificationsCtrl,
      $scope: scope
  )

  it 'should set the certification names and users on scope', ->
    expect(scope.certificationNames).toEqualData undefined
    expect(scope.users).toEqualData undefined

    $httpBackend.flush()

    expect(scope.certificationNames).toEqual certificationNames
    expect(scope.users).toEqual users
