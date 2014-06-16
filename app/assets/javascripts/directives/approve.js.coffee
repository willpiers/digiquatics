@digiquatics.directive 'approveRequest', ->
  restrict: 'E'
  templateUrl: 'approve.html'
  scope:
    request: '=info'

  link: (scope, element, attrs) ->
    element.find('.btn').bind 'click', ->
      scope.request.approved = true
      scope.request.active = false
      scope.request.$update

      scope.request.$update (updatedRequest, putResponseHeaders) ->
        console.log 'Great Success!'
        console.log updatedRequest

      scope.$apply()
