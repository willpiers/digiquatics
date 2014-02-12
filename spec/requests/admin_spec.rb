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
          login_as(non_admin, scope: :user)
        end

        it 'should redirect to sign in page' do
          expect { click_link('Users').to redirect_to(new_user_session_path) }
        end
      end

      describe 'as admin' do
        before do
          Warden.test_reset!
          login_as(admin, scope: :user)
        end

        it 'should redirect to sign in page' do
          expect { click_link('Users').to redirect_to(users_path) }
        end
      end
    end

    describe 'admin dashboard' do
      describe 'as non-admin' do
        before do
          login_as(non_admin, scope: :user)
        end

        it 'should redirect to sign in page' do
          expect { click_link('Admin Dashboard').to redirect_to(new_user_session_path) }
        end
      end

      describe 'as admin' do
        it 'should redirect to sign in page' do
          expect { click_link('Admin Dashboard').to redirect_to(new_user_session_path) }
        end
      end
    end
  end
end
