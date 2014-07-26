@digiquatics.controller 'TimeOffCtrl', ['$scope', 'TimeOff', 'Users',
                                       'Locations', 'Positions',
  @UsersCtrl = ($scope, TimeOff, Users, Locations, Positions) ->
    # Services
    $scope.timeOff = TimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.totalDisplayed = 10

    $scope.loadMore = ->
      $scope.totalDisplayed += 50

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]
