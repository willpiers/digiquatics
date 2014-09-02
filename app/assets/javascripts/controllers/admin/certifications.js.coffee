@digiquatics.controller 'CertificationsCtrl', ['$scope', 'Users', 'Locations', 'CertificationNames', 'Certifications'
  @CertificationsCtrl = ($scope, Users, Locations, CertificationNames, Certifications) ->

    $scope.predicate =
      value: '-user.last_name'

    $scope.users = Users.index()
    $scope.locations = Locations.index()
    $scope.certificationNames = CertificationNames.index()
    $scope.employeeCertifications = Certifications.index()

    $scope.userAdmin = (user) ->
      user.admin == true

    $scope.localToUtc = (expirationDate) ->
      moment(expirationDate).utc().format('MM/DD/YYYY')

    $scope.checkId = (certification, count) ->
      console.log $scope.certificationNames[0].id
      baseline = $scope.certificationNames[0].id
      if certification.certification_name_id is (count + baseline) then true
      else false

    $scope.thArrow = (current_column, anchored_column) ->
      if current_column == anchored_column then true

    $scope.today = moment()
    $scope.ninetyDays = moment().add('days', 90)
    $scope.onehundredeighty = moment().add('days', 180)

    $scope.cssClass = (certification) ->
      if      moment(certification).isBefore($scope.today) ||
              moment(certification).isSame($scope.today) then 'red'
      else if moment(certification).isAfter($scope.today) &&
              moment(certification).isBefore($scope.ninetyDays) then 'yellow'
      else if moment(certification).isAfter($scope.ninetyDays) &&
              moment(certification).isBefore($scope.onehundredeighty) then 'blue'
      else 'green'
]
