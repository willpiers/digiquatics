require 'spec_helper'

describe 'locations' do
  let(:account) { FactoryGirl.create(:account) }
  let(:position) { FactoryGirl.create(:position) }
  let(:location) { FactoryGirl.create(:location, account_id: account.id) }

  let!(:user) do
    FactoryGirl.create(:user,
                       account_id: account.id,
                       position_id: position.id,
                       location_id: location.id)
  end

  before do
    sign_in user, no_capybara: true
    get '/locations.json'
  end

  describe 'GET /locations.json' do
    let(:actual) { JSON.parse(response.body) }

    it 'should have user\'s locations data' do
      actual.count.should eq 1
      actual.first['name'].should eq location.name
    end
  end
end
