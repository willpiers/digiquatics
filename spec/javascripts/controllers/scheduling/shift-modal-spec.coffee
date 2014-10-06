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
      $httpBackend.expectPOST '/shifts.json',
        user_id: 1
        start_time: moment()
        end_time: moment()
        location_id: 2
        position_id: 3
      .respond {}

    it 'creates multiple shifts if recurring'

    it 'updates a shift if shift'

    it 'closes the modal', ->
      @controller.cancel()

      @modalInstanceStub.dismiss.should.have.been.calledOnce

    it 'broadcasts that a new shift was created'

  describe '#delete', ->
