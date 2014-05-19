@digiquatics.directive 'dqUserRow', [
  ->
    restrict: 'A'
    templateUrl: 'user-row.html'
    scope:
      user: '=dqUserRow' # not necessary as user is passed in
]
