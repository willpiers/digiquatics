require 'spec_helper'

describe 'admin setup' do
  subject { page }

  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) do
    FactoryGirl.create(:admin,
                       account_id: account.id,
                       location_id: location.id,
                       position_id: position.id)
  end

  let(:non_admin) do
    FactoryGirl.create(:user,
                       account_id: account.id,
                       location_id: location.id,
                       position_id: position.id)
  end

  before { sign_in user }

  describe 'manage' do

    describe 'users' do
      describe 'as non-admin' do
        before do
          sign_in non_admin
          visit users_path
        end

        it { should_not have_link('Manage Users', href: users_path) }

        it 'should redirect to sign_in' do
          current_path.should == signin_path
        end
      end

      describe 'as admin' do
        before do
          click_link('Users')
        end

        it 'should go to users index' do
          current_path.should == users_path
        end
      end
    end

    describe 'admin dashboard' do
      describe 'as non-admin' do
        before do
          sign_in non_admin
          visit admin_dashboard_path
        end

        it 'should redirect to sign_in' do
          current_path.should == signin_path
        end
      end

      describe 'as admin' do
        before { click_link('Admin Dashboard') }

        it 'should go to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end
    end
  end
end
