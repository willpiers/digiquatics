@digiquatics.directive 'dqUserRow', [
  ->
    restrict: 'A'
    templateUrl: 'users/user-row.html'
    scope:
      user: '=dqUserRow' # not necessary as user is passed in
]
