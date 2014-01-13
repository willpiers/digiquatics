require 'spec_helper'

describe 'Authentication' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, location_id: location.id,
    position_id: position.id, account_id: account.id) }

  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger', text: 'Invalid') }

      describe 'after visiting another page' do
        before { click_link "Aquatics App Beta" }

        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

  	describe 'with valid information' do

      before do
        fill_in 'Email',    with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      it { should have_title(user.first_name) }
      it { should have_link('My Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

  		describe 'followed by signout' do
        before { click_link 'Sign out' }

        it { should have_link('Sign in') }
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
            expect(page).to have_title('Aquatics App')
          end
        end
      end

      describe 'in the Users controller' do
        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }

          it { should have_title('Sign in') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }

          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe 'visiting the user index' do
      before { visit users_path }
      it { should have_title('Sign in') }
    end
  end

  describe 'as wrong user' do
    let(:wrong_user) { FactoryGirl.create(:user,
      email: 'wrong@example.com') }

    before { sign_in user, no_capybara: true }

    describe 'submitting a GET request to the Users#edit action' do
      before { get edit_user_path(wrong_user) }

      specify { expect(response.body).not_to match(full_title('Update your profile')) }
      specify { expect(response).to redirect_to(root_url) }
    end

    describe 'submitting a PATCH request to the Users#update action' do
      before { patch user_path(wrong_user) }

      specify { expect(response).to redirect_to(root_url) }
    end
  end
end