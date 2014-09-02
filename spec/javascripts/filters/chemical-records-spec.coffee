describe 'chemicalRecordsFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'formatTime', ->
    it 'should format with readable time and date', inject((formatTimeFilter) ->
      formatTimeFilter('2014-03-07T11:15:00.000-07:00').should.equal '11:15:00 - 03/07/2014'

      formatTimeFilter('1091-12-17T01:00:00.000-07:00').should.equal '01:00:00 - 12/17/1091'
    )
