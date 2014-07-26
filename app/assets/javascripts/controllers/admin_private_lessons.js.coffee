@digiquatics.controller 'AdminPrivateLessonsCtrl', ['$scope', 'AdminPrivateLessons',
                                             'Locations'
  @AdminPrivateLessonsCtrl = ($scope, AdminPrivateLessons, Locations) ->
      $scope.adminPrivateLessons = AdminPrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.totalDisplayed = 10

      $scope.loadMore = ->
        $scope.totalDisplayed += 50

      $scope.predicate =
        value: 'created_at'

      $scope.thArrow = (current_column, anchored_column) ->
        if current_column == anchored_column then true
]
