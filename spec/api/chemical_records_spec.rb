require 'spec_helper'

describe 'chemical records' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:pool) { FactoryGirl.create(:pool, location_id: location.id) }

  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id)
  end

  let!(:chemical_record) do
    FactoryGirl.create(:chemical_record,
                       user_id: user.id,
                       pool_id: pool.id,
                       ph: 7.5,
                       total_chlorine_ppm: 7.5)
  end

  before do
    login_as(user, scope: :user)
    get '/chemical_records.json'
  end

  describe 'GET /chemical_records.json' do
    let(:actual) { JSON.parse(response.body) }

    it 'should have chemical info' do
      actual.first['id'].should == chemical_record.id
    end

    it 'should have a pool' do
      actual.first['pool_id'].should eq pool.id
      actual.first['pool']['id'].should eq pool.id
    end

    it 'should have a location' do
      actual.first['pool']['location_id'].should eq location.id
      actual.first['pool']['location']['id'].should eq location.id
    end
  end
end
