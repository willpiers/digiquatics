require 'spec_helper'

describe 'pools' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:pool) { FactoryGirl.create(:pool, location_id: location.id) }

  let!(:user) do
    FactoryGirl.create(:user,
                       account_id: account.id,
                       location_id: location.id)
  end

  before do
    login_as(user, scope: :user)
    get '/pools.json'
  end

  describe 'GET /pools.json' do
    let(:actual) { JSON.parse(response.body) }

    it 'should have user\'s pools data' do
      actual.count.should eq 1
      actual.first['name'].should eq pool.name
    end
  end
end
