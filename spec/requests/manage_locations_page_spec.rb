require 'spec_helper'

describe 'Manage Locations' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) { FactoryGirl.create(:location) }
    let(:position) { FactoryGirl.create(:position) }
    let(:user) { FactoryGirl.create(:user, account_id: account.id,
      location_id: location.id, position_id: position.id) }

    before do
      sign_in user
      FactoryGirl.create(:location, name: 'Carmody Rec Center',
        account_id: account.id)
      FactoryGirl.create(:location, name: 'Green Mtn Rec Center',
        account_id: account.id)
      location.update_attribute(:account_id, account.id)
      visit locations_path
    end

    it { should have_title('Manage Locations') }
    it { should have_selector('h1', text: 'Manage Locations') }

    it 'should list each location' do
      Location.all.each do |location|
        location.account_id.should eq(user.account_id)
        page.should have_content(location.name)
      end
    end

    describe 'links' do
      it { should have_link('New Location') }
      it { should have_link('Edit') }
      it { should have_link('Delete') }
    end

    describe 'creating a new location' do
      before do
        visit new_location_path
        fill_in 'Name', with: 'Ridge Rec Center'
        pp locations_path
      end

      it 'should create a new location' do
        expect { click_button 'Create Location'}
        .to change(Location, :count).by(1)
      end
    end
  end
end
