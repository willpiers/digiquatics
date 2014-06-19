@digiquatics.directive 'denyRequest', ->
  restrict: 'E'
  templateUrl: 'deny.html'
  scope:
    request: '=info'

  link: (scope, element, attrs) ->
    element.bind 'click', ->
      scope.request.approved = false
      scope.request.active = false
      scope.request.$update

      scope.request.$update (updatedRequest, putResponseHeaders) ->
        console.log 'Great Success!'
        console.log updatedRequest

      scope.$apply()
