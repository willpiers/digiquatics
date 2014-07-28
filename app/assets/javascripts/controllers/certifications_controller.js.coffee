# @digiquatics.controller 'CertificationsCtrl', ['$scope', 'CertificationNames', 'Locations', 'Users',
#   @CertificationsCtrl = ($scope, CertificationNames, Users, Locations) ->

#     $scope.predicate =
#       value: 'lastName'

#     $scope.users = Users.index()
#     $scope.locations = Locations.index()
#     $scope.certificationNames = CertificationNames.index()
#     # $scope.employeeCertifications = Certifications.index()

# ]

@digiquatics.controller 'CertificationsCtrl', ['$scope', 'Users', 'Locations', 'CertificationNames', 'Certifications'
  @UsersCtrl = ($scope, Users, Locations, CertificationNames, Certifications) ->

    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.certificationNames = CertificationNames.index()
    $scope.employeeCertifications = Certifications.index()

    $scope.userAdmin = (user) ->
      user.admin == true

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true
]

