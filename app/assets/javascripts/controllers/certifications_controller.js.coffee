@digiquatics.controller 'CertificationsCtrl', ['$scope', 'Certifications',
  @CertificationsCtrl = ($scope, Certifications) ->
    $scope.predicate =
      value: 'firstName'

    Certifications.get (data) ->
      $scope.certNames = data.certification_names
      $scope.users = data.users
]
