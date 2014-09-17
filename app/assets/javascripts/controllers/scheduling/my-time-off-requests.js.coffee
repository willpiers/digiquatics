@digiquatics.controller 'MyTimeOffCtrl', ['$scope', 'MyTimeOff', 'Users',
                                                'Locations', 'Positions',
  @UsersCtrl = ($scope, MyTimeOff, Users, Locations, Positions) ->
    # Services
    $scope.myTimeOff = MyTimeOff.index()
    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.positions = Positions.index()

    # Other
    $scope.predicate =
      value: 'last_name'

    $scope.cssClass = (request) ->
      if request.approved == true && request.active == false then 'success'
      else if request.approved == false && request.active == false then 'danger'
      else 'warning'

    $scope.checkActive = (request) ->
      if request.active == false then false
      else true

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.startsAt = (request) ->
      if request.all_day
        moment(request.starts_at).format('M/D/YY')
      else
        moment(request.ends_at).format('M/D/YY @ h:mma')

    $scope.endsAt = (request) ->
      if request.all_day
        moment(request.ends_at).format('M/D/YY')
      else
        moment(request.ends_at).format('M/D/YY @ h:mma')
]
