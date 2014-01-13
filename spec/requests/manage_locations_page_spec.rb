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
      visit admin_dashboard_path
    end

    it { should have_content('Manage Locations') }

    it 'should list each location' do
      Location.all.each do |location|
        location.account_id.should eq(user.account_id)
        page.should have_content(location.name)
      end
    end

    describe 'links' do
      it { should have_link('New', href: new_location_path) }
      it { should have_link('Edit') }
      it { should have_link('Delete') }
    end

    describe 'creating a new location' do
      before do
        visit new_location_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new location and redirect to index' do
        expect { click_button 'Create Location'}
        .to change(Location, :count).by(1)

        current_path.should == admin_dashboard_path
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end
    end

    describe 'editing an existing location' do
      before do
        visit edit_location_path(location)
        fill_in 'Name', with: 'new location name'
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end

      it 'should update the location and redirect to admin dashboard' do
        expect { click_button 'Update Location'}
        .to_not change(Location, :count).by(1)

        expect(location.reload.name).to eq('new location name')
        current_path.should == admin_dashboard_path
      end
    end

    describe 'deleting a location' do
      before do
        visit admin_dashboard_path
      end

      it { should have_link('Delete', href: location_path(location)) }

      it 'should be able to delete location' do
        expect do
          click_link('Delete', match: :first)
        end.to change(Location, :count).by(-1)

        current_path.should == admin_dashboard_path
      end
    end
  end
end
