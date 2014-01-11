require 'spec_helper'

describe 'admin setup' do
  subject { page }

  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:admin, account_id: account.id, 
    location_id: location.id, position_id: position.id) }
  before { sign_in user }

  describe 'manage' do
    describe 'users' do
      before { click_link('Manage Users') }

      it { should have_title(full_title('Users')) }
    end

    describe 'account' do
      before { click_link('Manage Account') }

      it { should have_title(full_title('Manage Account')) }
    end
  end
end
