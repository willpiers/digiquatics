window.timeDigest = ->
  rootScope = $("[ng-app='digiquatics']").scope().$root
  rootScope.$$postDigest -> console.timeEnd 'digestTime'
  console.time 'digestTime'
  rootScope.$apply()

window.countWatchers = (scope) ->
  scope ?= $("[ng-app='digiquatics']").scope().$root
  count = scope.$$watchers?.length ? 0

  recursivelyCountWatchers = (scope) ->
    return 0 unless scope

    count = scope.$$watchers?.length ? 0
    count += recursivelyCountWatchers scope.$$childHead
    count += recursivelyCountWatchers scope.$$nextSibling

    return count

  count += recursivelyCountWatchers scope.$$childHead
