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

      $scope.cssClass = (created_at) ->
        if moment(created_at).isAfter(moment().subtract('days', 3)) then 'success'
        else if moment(created_at).isAfter(moment().subtract('days', 8)) then 'warning'
        else 'danger'
]
