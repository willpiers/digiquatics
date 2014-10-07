describe 'ShiftModalCtrl', ->
  beforeEach angular.mock.module 'digiquatics'

  beforeEach inject (_$httpBackend_, @$rootScope, @$controller) ->
    @$httpBackend = _$httpBackend_
    @scope = @$rootScope.$new()

    @modalInstanceStub =
      dismiss: @stub()
      close: @stub()

    @controller = @$controller 'ShiftModalCtrl',
      $scope: @scope
      $modalInstance: @modalInstanceStub
      shift: null
      data:
        location: 2
        user:
          id: 1
          shifts: []
    @user = @controller.data.user

  describe '#cancel', ->
    it 'dismisses the modal', ->
      @controller.cancel()

      @modalInstanceStub.dismiss.should.have.been.calledOnce

  describe '#ok', ->
    before ->
      @stub toastr, 'success'
      @stub toastr, 'info'
      @stub toastr, 'error'

    beforeEach ->
      @startTime = moment().toString()
      @endTime = moment().add(2, 'hours').toString()

    it 'creates a new shift if no shift', ->
      @$httpBackend.expectPOST '/shifts.json',
        user_id: 1
        location_id: 2
        position_id: 3
        start_time: @startTime
        end_time: @endTime
      .respond {}

      @controller.ok 3, @startTime, @endTime

      @$httpBackend.flush()

    it 'creates multiple shifts if recurring', ->
      @scope.state.recurring = true
      @scope.state.occurences = 2

      @controller.ok 3, @startTime, @endTime

      @user.shifts.push.should.have.been.calledTwice
      @modalInstanceStub.close.should.have.been.calledOnce

    it 'updates a shift if shift', ->
      @controller = @$controller 'ShiftModalCtrl',
        $scope: @scope
        $modalInstance: @modalInstanceStub
        shift: id: 54
        data:
          location: 2
          user:
            id: 1
            shifts: []

      @$httpBackend.expectPUT '/shifts/54.json',
        id: 54
        start_time: @startTime
        end_time: @endTime
        position_id: 3
      .respond {}

      @controller.ok 3, @startTime, @endTime
      _.remove(@user.shifts).should.have.been.calledOnce
      @user.shifts.push.should.have.been.calledOnce

      @$httpBackend.flush()

    it 'closes the modal', ->
      @controller.ok 1, @startTime, @endTime
      @modalInstanceStub.close.should.have.been.calledOnce

    it 'broadcasts that a new shift was created', (done) ->
      @$rootScope.$on 'shifts:created', -> done()

      @$httpBackend.expectPOST('/shifts.json').respond {}

      @controller.ok 1, @startTime, @endTime

      @$httpBackend.flush()

  describe '#delete', ->
    beforeEach ->
      @controller = @$controller 'ShiftModalCtrl',
        $scope: @scope
        $modalInstance: @modalInstanceStub
        shift: id: 52
        data:
          location: 2
          user:
            id: 1
            shifts: []
      @user = @controller.data.user

    it 'deletes the shift', ->
      @$httpBackend.expectDELETE('/shifts/52.json').respond 'success'

      @controller.delete()
      _.remove(@user.shifts).should.have.been.calledOnce

      @$httpBackend.flush()

    it 'closes the modal', ->
      @controller.delete()
      @modalInstanceStub.close.should.have.been.calledOnce
