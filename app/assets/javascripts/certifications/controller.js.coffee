    @aquaticsApp.controller 'CertsCtrl', ['$scope', 'Certs',
      @CertsCtrl = ($scope, Certs) ->
        $scope.formatDate = (dateString)  ->
          d = new Date(dateString)

          curr_month = d.getMonth() + 1
          curr_date = d.getDate()
          curr_year = d.getFullYear()

          "#{curr_month}/#{curr_date}/#{curr_year}"

        $scope.sorter =
          value: 'firstName'

        Certs.get (data) ->
          $scope.certNames = data.certification_names
          $scope.users = data.users
    ]
