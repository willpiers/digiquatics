@digiquatics.controller 'MyPrivateLessonsCtrl', [
  '$scope'
  'MyPrivateLessons'
  'Locations'

  @AdminPrivateLessonsCtrl = ($scope, MyPrivateLessons, Locations) ->
      $scope.myPrivateLessons = MyPrivateLessons.index()

      $scope.locations = Locations.index()

      $scope.predicate =
        value: 'claimed_on'

      $scope.thArrow = (current_column, anchored_column) ->
        if current_column == anchored_column then true
]
