describe.only 'ShiftModalCtrl', ->
  beforeEach angular.mock.module 'digiquatics'

  beforeEach inject (@_$httpBackend_, @$rootScope, @$controller) ->
    $httpBackend = @_$httpBackend_
    scope = @$rootScope.$new()

    @modalInstanceStub = dismiss: @stub()

    @controller = @$controller 'ShiftModalCtrl',
      $scope: scope
      $modalInstance: @modalInstanceStub
      shift: {}
      data: {}

  describe '#cancel', ->
    it 'dismisses the modal', ->
      @controller.cancel()

      @modalInstanceStub.dismiss.should.have.been.calledOnce

  describe '#ok', ->
    it 'creates a new shift if no shift', ->
      $httpBackend.expectGET


    it 'creates multiple shifts if recurring'

    it 'updates a shift if shift'

    it 'closes the modal'

    it 'broadcasts that a new shift was created'

  describe '#delete', ->
