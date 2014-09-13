@digiquatics.controller 'ArchivedTimeOffCtrl', ['$scope', 'ArchivedTimeOff', 'Users',
                                                'Locations', 'Positions',
  @UsersCtrl = ($scope, ArchivedTimeOff, Users, Locations, Positions) ->
    # Services
    $scope.archivedTimeOff = ArchivedTimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.cssClass = (request) ->
      if request.approved == true then 'success'
      else 'danger'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.checkActive = (request) ->
      if request.active == false and request.approved == true then false
      else true

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
