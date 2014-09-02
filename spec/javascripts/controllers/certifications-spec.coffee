describe 'CertificationsCtrl', ->
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

  beforeEach angular.mock.module('digiquatics')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/users.json').respond users
    $httpBackend.expectGET('/locations.json').respond []
    $httpBackend.expectGET('/certification_names.json').respond certNames
    $httpBackend.expectGET('/certifications.json').respond []

    scope = $rootScope.$new()
    ctrl = $controller CertificationsCtrl,
      $scope: scope
  )

  it 'should set the certification names and users on scope', ->
    scope.users.length.should.equal 0

    $httpBackend.flush()

    scope.users.length.should.equal 2
