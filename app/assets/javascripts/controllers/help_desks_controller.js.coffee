@digiquatics.controller 'HelpDesksCtrl', ['$scope', 'HelpDesks',
                                             'Locations'
  @HelpDesksCtrl = ($scope, HelpDesks, Locations) ->
      $scope.helpDesks = HelpDesks.index()

      $scope.predicate =
        value: 'created_at'

      $scope.thArrow = (current_column, anchored_column) ->
        if current_column == anchored_column then true

      $scope.showPic = (data) ->
        data.help_desk_attachment_file_name?

      $scope.cssClass = (item) ->
        if      item.urgency == 'Low'    then 'success'
        else if item.urgency == 'Medium' then 'warning'
        else    'danger'

      $scope.locations = Locations.index()
]
