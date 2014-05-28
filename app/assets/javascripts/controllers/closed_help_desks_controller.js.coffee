@digiquatics.controller 'ClosedHelpDesksCtrl', ['$scope', 'ClosedHelpDesks',
                                                'Locations'
  @ClosedHelpDesksCtrl = ($scope, ClosedHelpDesks, Locations) ->
      $scope.closedHelpDesks = ClosedHelpDesks.index()

      $scope.predicate =
        value: 'created_at'

      $scope.showPic = (data) ->
        data.help_desk_attachment_file_name?

      $scope.cssClass = (item) ->
        if      item.urgency == 'Low'    then 'success'
        else if item.urgency == 'Medium' then 'warning'
        else    'danger'

      $scope.locations = Locations.index()
]
