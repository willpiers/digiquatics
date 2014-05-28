require 'spec_helper'

describe 'Authentication' do
  let(:account)  { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let(:position) { FactoryGirl.create(:position) }

  let(:user) do
    FactoryGirl.create(:user,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  subject { page }

  describe 'signin page' do
    before { visit new_user_session_path }

    it { should have_content('Welcome to DigiQuatics') }
    it { should have_title('Sign In') }
  end

  describe 'signin' do
    before { visit new_user_session_path }

    describe 'with invalid information' do
      before { click_button 'Sign in to your account' }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert') }
    end

    describe 'with valid information' do
      before do
        fill_in 'Email',    with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_title('Dashboard') }
      it { should have_link('My Profile', href: user_path(user)) }
      it { should have_link('Sign Out', href: destroy_user_session_path) }
      it { should_not have_link('Sign In', href: new_user_session_path) }

      describe 'followed by signout' do
        before { first(:link, 'Sign Out').click }

        it { should have_content('Welcome to DigiQuatics') }
      end
    end

    describe 'authorization' do
      describe 'for non-signed-in users' do
        describe 'when attempting to visit a protected page' do
          before do
            visit edit_user_path(user)
            fill_in 'Email',    with: user.email
            fill_in 'Password', with: user.password
            click_button 'Sign in'
          end
        end

        describe 'after signing in' do
          it 'should render the desired protected page' do
            expect(page).to have_title('DigiQuatics')
          end
        end
      end

      describe 'in the Users controller' do
        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }

          it { should have_title('Sign In') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }

          specify { expect(response).to redirect_to(new_user_session_path) }
        end
      end
    end

    describe 'visiting the user index' do
      before { visit users_path }
      it { should have_title('Sign In') }
    end
  end

  describe 'as wrong user' do
    let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }

    before { login_as(user, scope: :user) }

    describe 'submitting a GET request to the Users#edit action' do
      before { get edit_user_path(wrong_user) }

      it { response.body.should_not match(full_title('Update your profile')) }
      it { response.should redirect_to(new_user_session_path) }
    end

    describe 'submitting a PATCH request to the Users#update action' do
      before { patch user_path(wrong_user) }

      specify { response.should redirect_to(new_user_session_path) }
    end
  end
end
