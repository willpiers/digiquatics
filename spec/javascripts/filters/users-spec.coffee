describe 'usersFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'age', ->
    it 'should give the age in years from a date', inject((ageFilter) ->
      ageFilter('1992-09-14T18:00:00.000-06:00').should.equal 21
      ageFilter('1993-01-14T18:00:00.000-06:00').should.equal 21
    )

    it 'should handle null correctly', inject((ageFilter) ->
      ageFilter(null).should.equal ''
    )

  describe 'booleanToWords', ->
    it 'should convert a boolean to yes/no', inject((booleanToWordsFilter) ->
      booleanToWordsFilter(true).should.equal 'Yes'
      booleanToWordsFilter(false).should.equal 'No'
    )
