require 'spec_helper'

describe 'Account pages' do
  let!(:account) { FactoryGirl.create(:account) }

  subject { page }

  describe 'signup' do
    before do
      Warden.test_reset!
      visit new_user_path
    end

    let(:submit) { 'Create Account' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        select account.name,          from: 'Account'
        fill_in 'First Name',         with: 'First'
        fill_in 'Last Name',          with: 'Last'
        fill_in 'Phone Number',       with: '1234'
        fill_in 'Email',              with: 'new@account.com'
        fill_in('Password *',         with: 'foobar77', exact: true)
        fill_in('Confirm Password *', with: 'foobar77', exact: true)
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('new@account.com') }

        describe 'should sign the user in' do
          it { should have_link('Sign out') }
          it { should have_selector('div.alert') }
        end
      end
    end
  end

  describe 'edit' do
    let!(:user) { FactoryGirl.create(:user, account_id: account.id) }
    before do
      visit edit_account_path(account)
    end

    describe 'should not have user fields' do
      it { should_not have_content('Basic User Information') }
    end
  end
end
