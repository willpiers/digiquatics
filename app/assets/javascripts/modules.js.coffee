@digiquatics = angular.module 'digiquatics',
  [
    'templates'
    'ngResource'
    'digiquaticsFilters'
    'ui.bootstrap'
    'ng-rails-csrf'
  ]

@digiquaticsFilters = angular.module 'digiquaticsFilters', []
