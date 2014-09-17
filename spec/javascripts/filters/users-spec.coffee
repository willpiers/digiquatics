describe 'usersFilters', ->
  beforeEach angular.mock.module('digiquaticsFilters')

  describe 'age', ->
    it 'should give the age in years from a date', inject((ageFilter) ->
      ageFilter(moment().subtract(21, 'years')).should.equal 21
      ageFilter(moment().subtract(22, 'years').add(3, 'months')).should.equal 21
    )

    it 'should handle null correctly', inject((ageFilter) ->
      ageFilter(null).should.equal ''
    )

  describe 'booleanToWords', ->
    it 'should convert a boolean to yes/no', inject((booleanToWordsFilter) ->
      booleanToWordsFilter(true).should.equal 'Yes'
      booleanToWordsFilter(false).should.equal 'No'
    )
