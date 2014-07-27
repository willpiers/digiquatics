@digiquatics.controller 'PrivateLessonsCtrl', ['$scope', 'PrivateLessons',
                                             'Locations'
  @PrivateLessonsCtrl = ($scope, PrivateLessons, Locations) ->
      $scope.privateLessons = PrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'created_at'

      $scope.totalDisplayed = 10

      $scope.loadMore = ->
        $scope.totalDisplayed += 50

      $scope.thArrow = (current_column, anchored_column) ->
        if current_column == anchored_column then true
]
