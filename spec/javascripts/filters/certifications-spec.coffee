describe 'certificationsFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'formatDate', ->
    it 'should format the date with month/day/year', inject((formatDateFilter) ->
      formatDateFilter('2014-03-07T11:00:00.000-07:00').should.equal '3/7/2014'
      formatDateFilter('1091-12-17T11:00:00.000-07:00').should.equal '12/17/1091'
    )

    it 'should show blank if null/undefined', inject((formatDateFilter) ->
      formatDateFilter(undefined).should.equal ''
      formatDateFilter(null).should.equal ''
    )
