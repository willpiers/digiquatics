require 'spec_helper'

describe 'certification expirations' do
  let(:account) { FactoryGirl.create(:account) }
  let(:position) { FactoryGirl.create(:position) }
  let(:location) { FactoryGirl.create(:location) }

  let!(:user) do
    FactoryGirl.create(:user,
                       account_id: account.id,
                       position_id: position.id,
                       location_id: location.id)
  end

  let(:certification_name) do
    FactoryGirl.create(:certification_name,
                       account_id: account.id)
  end

  let!(:certification) do
    FactoryGirl.create(:certification,
                       user_id: user.id,
                       certification_name_id: certification_name.id,
                       expiration_date: '2014-10-24T18:00:00.000-06:00')
  end

  before do
    login_as(user, scope: :user)
    get '/certification_expirations.json'
  end

  describe 'GET certification_expirations.json' do
    let(:actual) { JSON.parse(response.body) }
    let(:actual_cert_name) { actual['certification_names'].first }

    it 'should have users data' do
      actual['users'].should eq [
        {
          'id'                              => user.id,
          'lastName'                        => user.last_name,
          'firstName'                       => user.first_name,
          'location'                        => location.name,
          certification_name.name           => '2014-10-24T18:00:00.000-06:00',
          "#{certification_name.id}"        => 'CPR/AED',
          "#{certification_name.name}class" => 'warning'
        }
      ]
    end

    it 'should have certification names data' do
      actual['certification_names'].count.should eq 1
      actual_cert_name['id'].should eq certification_name.id
      actual_cert_name['account_id'].should eq certification_name.account_id
      actual_cert_name['name'].should eq certification_name.name
    end
  end
end
