describe 'certificationsFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'formatDate', ->
    it 'should format the date with month/day/year', inject((formatDateFilter) ->
      expect(formatDateFilter('2014-03-07T17:00:00.000-07:00')).toBe '3/7/2014'
      expect(formatDateFilter('1091-12-17T17:00:00.000-07:00')).toBe '12/17/1091'
    )

    it 'should show blank if null/undefined', inject((formatDateFilter) ->
      expect(formatDateFilter(undefined)).toBe ''
      expect(formatDateFilter(null)).toBe ''
    )
