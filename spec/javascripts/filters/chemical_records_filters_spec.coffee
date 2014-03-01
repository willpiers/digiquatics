describe 'chemicalRecordsFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'formatTime', ->
    it 'should format with readable time and date', inject((formatTimeFilter) ->
      expect(formatTimeFilter('2014-03-07T17:15:00.000-07:00'))
      .toBe '5:15:00 PM - 3/7/2014'

      expect(formatTimeFilter('1091-12-17T01:00:00.000-07:00'))
      .toBe '1:00:04 AM - 12/11/1091'
    )
