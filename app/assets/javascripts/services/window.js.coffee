@digiquatics.factory 'Window', [
  '$window'

  ($window) ->
    class Window
      @xs = $window.innerWidth < 768

      angular.element($window).bind 'resize', =>
        @xs = $window.innerWidth < 768

]
