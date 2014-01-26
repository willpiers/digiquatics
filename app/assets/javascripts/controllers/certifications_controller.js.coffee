@digiquatics.controller 'CertificationsCtrl', ['$scope', 'Certifications',
  @CertificationsCtrl = ($scope, Certifications) ->
    $scope.sorter =
      value: 'firstName'

    data = Certifications.get (data) ->
      $scope.certNames = data.certification_names
      $scope.users = data.users
]
