require 'spec_helper'

describe 'Manage Locations' do
  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) do
      FactoryGirl.create(:location, account_id: account.id)
    end

    let(:position) { FactoryGirl.create(:position) }
    let(:user) do
      FactoryGirl.create(:admin,
                         account_id: account.id,
                         location_id: location.id,
                         position_id: position.id)
    end

    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:location, name: 'Carmody Rec Center',
                                    account_id: account.id)
      visit admin_dashboard_path
    end

    # it { should have_content('Manage Locations') }
    it { should have_link('New', href: new_location_path) }

    describe 'admin dashboard' do
      it 'should list each location' do
        Location.all.each do |location|
          location.account_id.should eq(user.account_id)
          should have_content(location.name)
          should have_link('Edit', href: edit_location_path(location))
          should have_link('Delete', href: location_path(location))
        end
      end
    end

    describe 'creating a new location' do
      before do
        visit new_location_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new location and redirect to index' do
        expect { click_button 'Create Location' }
        .to change(Location, :count).by(1)

        current_path.should eq admin_dashboard_path
      end

      # describe 'clicking the back button' do
      #   before { click_link 'Back' }

      #   it 'should redirect to admin dash' do
      #     current_path.should eq admin_dashboard_path
      #   end
      # end
    end

    describe 'editing an existing location' do
      before do
        visit edit_location_path(location)
        fill_in 'Name', with: 'new location name'
      end

      # describe 'clicking the back button' do
      #   before { click_link 'Back' }

      #   it 'should redirect to admin dash' do
      #     current_path.should eq admin_dashboard_path
      #   end
      # end

      it 'should update the location and redirect to admin dashboard' do
        expect { click_button 'Update Location' }
        .to_not change(Location, :count)

        location.reload.name.should eq 'new location name'
        current_path.should eq admin_dashboard_path
      end
    end

    describe 'deleting a location' do
      before do
        visit admin_dashboard_path
      end

      it { should have_link('Delete', href: location_path(location)) }

      it 'should be able to delete location' do
        expect { click_link('Delete', match: :first) }
        .to change(Location, :count).by(-1)

        current_path.should eq admin_dashboard_path
      end
    end
  end
end
