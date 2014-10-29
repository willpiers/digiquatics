describe 'ShiftsCtrl', ->
  beforeEach angular.mock.module 'digiquatics'

  beforeEach inject (_$httpBackend_, @$rootScope, @$controller) ->
    @$httpBackend = _$httpBackend_
    @scope = @$rootScope.$new()

    @controller = @$controller 'ShiftsCtrl',
      $scope: @scope
      # @scope.subRequests = [
      #   shift_id: 1
      #   user_id: 1
      #   active: true
      # ]




  describe 'makes a shift yellow if sub request is present', ->
    it 'dismisses the modal', ->

      console.log @controller.subRequests[0]
      # @controller.cancel()

      # @modalInstanceStub.dismiss.should.have.been.calledOnce


