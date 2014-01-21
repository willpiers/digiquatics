describe 'filters', ->
  beforeEach module('aquaticsAppFilters')

  describe 'age', ->
    it 'should give the age in years from a date', inject((ageFilter) ->
      expect(ageFilter('1992-09-14T18:00:00.000-06:00')).toBe 21
      expect(ageFilter('1993-01-14T18:00:00.000-06:00')).toBe 21
    )

  describe 'booleanToWords', ->
    it 'should convert a boolean to yes/no', inject((booleanToWordsFilter) ->
      expect(booleanToWordsFilter(true)).toEqual 'Yes'
      expect(booleanToWordsFilter(false)).toEqual 'No'
    )

  describe 'formatDate', ->
    it 'should format the date with month/day/year', inject((formatDateFilter) ->
      expect(formatDateFilter('2014-03-07T17:00:00.000-07:00')).toBe '3/7/2014'
      expect(formatDateFilter('1091-12-17T17:00:00.000-07:00')).toBe '12/17/1091'
    )

