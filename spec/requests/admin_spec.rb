require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'admin setup' do
  subject { page }

  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:admin) do
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

  describe 'manage' do

    describe 'users' do
      describe 'as non-admin' do
        before do
          Warden.test_reset!
          login_as(non_admin, scope: :user)
          visit users_path
        end

        it 'should redirect to user profile and flash error' do
          current_path.should eq user_path(non_admin)
        end
      end

      describe 'as admin' do
        before do
          Warden.test_reset!
          login_as(admin, scope: :user)
          visit users_path
        end

        it 'should redirect to users index' do
          current_path.should eq users_path
        end
      end
    end

    describe 'admin dashboard' do
      describe 'as non-admin' do
        before do
          Warden.test_reset!
          login_as(non_admin, scope: :user)
          visit admin_dashboard_path
        end

        it 'should redirect to sign in page' do
          current_path.should eq(user_path(non_admin))
        end
      end

      describe 'as admin' do
        before do
          Warden.test_reset!
          login_as(admin, scope: :user)
          visit admin_dashboard_path
        end

        it 'should redirect to admin dash' do
          current_path.should eq admin_dashboard_path
        end
      end
    end
  end
end
