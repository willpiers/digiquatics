describe 'usersFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'age', ->
    it 'should give the age in years from a date', inject((ageFilter) ->
      expect(ageFilter('1992-09-14T18:00:00.000-06:00')).toBe 21
      expect(ageFilter('1993-01-14T18:00:00.000-06:00')).toBe 21
    )

    it 'should handle null correctly', inject((ageFilter) ->
      expect(ageFilter(null)).toBe ''
    )

  describe 'booleanToWords', ->
    it 'should convert a boolean to yes/no', inject((booleanToWordsFilter) ->
      expect(booleanToWordsFilter(true)).toEqual 'Yes'
      expect(booleanToWordsFilter(false)).toEqual 'No'
    )
