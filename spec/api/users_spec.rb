require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'users' do
  let(:account) { FactoryGirl.create(:account) }
  let(:position) { FactoryGirl.create(:position) }
  let(:location) { FactoryGirl.create(:location) }

  let!(:user) do
    FactoryGirl.create(:admin,
                       account_id: account.id,
                       position_id: position.id,
                       location_id: location.id)
  end

  before do
    login_as(user, scope: :user)
    get '/users.json'
  end

  describe 'GET /users.json' do
    let(:actual) { JSON.parse(response.body) }

    it 'should have current user\'s account\'s users' do
      actual.count.should eq 1
      actual.first['first_name'].should eq user.first_name
    end

    it 'should include location data' do
      actual.first['location'].should_not be_nil
    end

    it 'should include position data' do
      actual.first['position'].should_not be_nil
    end
  end
end
