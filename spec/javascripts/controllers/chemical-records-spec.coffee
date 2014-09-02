describe 'ChemicalRecordsCtrl', ->
  scope = $httpBackend = undefined

  chemicalRecords = [
    id: 1
    time_stamp: '2014-03-06T15:00:00.000-07:00'
    user_id: 3
    pool_id: 2
    pool: {}
  ,
    id: 2
    time_stamp: '2014-03-06T15:00:00.000-07:00'
    user_id: 3
    pool_id: 2
    pool: {}
  ]

  beforeEach angular.mock.module('digiquatics')

  beforeEach inject((_$httpBackend_, $rootScope, $controller) ->
    $httpBackend = _$httpBackend_

    $httpBackend.expectGET('/chemical_records.json').respond chemicalRecords
    $httpBackend.expectGET('/pools.json').respond null
    $httpBackend.expectGET('/locations.json').respond null

    scope = $rootScope.$new()
    ctrl = $controller ChemicalRecordsCtrl,
      $scope: scope
  )

  it 'should set the chemicalRecords on scope', ->
    scope.chemicalRecords.length.should.equal 0

    $httpBackend.flush()

    scope.chemicalRecords.length.should.equal 2

  it 'should set predicate for filter', ->
    scope.predicate.value.should.equal '-time_stamp'
