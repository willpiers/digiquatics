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

    describe 'locations' do
      before { click_link('Manage Locations') }

      it { should have_title(full_title('Manage Locations')) }  
      it { should have_selector('h1', text: 'Manage Locations') }
    end

    describe 'positions' do
      before { click_link('Manage Positions') } 

      it { should have_title(full_title('Manage Positions')) }
      it { should have_selector('h1', text: 'Manage Positions') }
    end

    #describe 'chemicals' do
     # before { click_link('Manage Chemicals') }

      #it { should have_title(full_title('Manage Chemicals')) }
      #it { should have_selector('h1', text: 'Manage Chemicals') }
    #end

    describe 'certifications' do
      before { click_link('Manage Certifications') }

      it { should have_title(full_title('Manage Certifications')) }
      it { should have_selector('h1', text: 'Manage Certifications') }
    end

    #describe 'lessons' do
     # before { click_link('Manage Lessons') }

      #it { should have_title(full_title('Manage Private Lessons')) }
      #it { should have_selector('h1', text: 'Manage Private Lessons') }
    #end

    describe 'account' do
      before { click_link('Manage Account') }

      it { should have_title(full_title('Manage Account')) }
    end
  end
end
