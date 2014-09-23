@digiquatics.controller 'PrivateLessonsCtrl', [
  '$scope'
  'PrivateLessons'
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

    $scope.cssClass = (created_at) ->
      if moment(created_at).isAfter(moment().subtract('days', 3)) then 'success'
      else if moment(created_at).isAfter(moment().subtract('days', 8)) then 'warning'
      else 'danger'
]
