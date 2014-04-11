@digiquatics.controller 'HelpDesksCtrl', ['$scope', 'HelpDesks',
                                             'Locations'
  @HelpDesksCtrl = ($scope, HelpDesks, Locations) ->
      $scope.helpDesks = HelpDesks.index()

      $scope.locations       = Locations.index()
]
