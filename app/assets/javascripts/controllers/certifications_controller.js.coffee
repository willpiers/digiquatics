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

    $scope.today = moment().format()
    $scope.ninetyDays = moment().add('days', 90).format()
    $scope.onehundredeighty = moment().add('days', 180).format()

    $scope.cssClass = (certification) ->
      if      moment(certification).isBefore($scope.today) ||
              moment(certification).isSame($scope.today) then 'red'
      else if moment(certification).isAfter($scope.today) &&
              moment(certification).isBefore($scope.ninetyDays) then 'yellow'
      else if moment(certification).isAfter($scope.ninetyDays) &&
              moment(certification).isBefore($scope.onehundredeighty) then 'blue'
      else 'green'
]




#   def css_class(date)
#     case date
#     when (Date.today - 3000.days)..(Date.today)
#       'danger'
#     when (Date.today)...(Date.today + 90.days)
#       'warning'
#     when (Date.today + 90.days)..(Date.today + 180.days)
#       'cert_blue'
#     else
#       'success'
#     end
#   end



# moment().add('days', 7);
