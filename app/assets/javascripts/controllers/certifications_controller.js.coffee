@digiquatics.controller 'CertificationsCtrl', ['$scope', 'Certifications', 'Locations',
  @CertificationsCtrl = ($scope, Certifications, Locations) ->
    $scope.predicate =
      value: 'lastName'

    $scope.locations = Locations.index()

    Certifications.get (data) ->
      $scope.certNames = data.certification_names
      $scope.users = data.users
]
