require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe 'Account pages' do
  let!(:account) { FactoryGirl.create(:account) }

  subject { page }

  describe 'signup' do
    before do
      visit new_user_registration_path
    end

    let(:submit) { 'Create Account' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        select account.name,        from: 'Account'
        fill_in 'First Name',       with: 'First'
        fill_in 'Preferred Name',   with: 'Dubbs'
        fill_in 'Last Name',        with: 'Last'
        fill_in 'Phone Number',     with: '1234'
        fill_in 'Email',            with: 'new@account.com'
        fill_in 'Password',         with: 'foobar77'
        fill_in 'Password Confirmation', with: 'foobar77'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('new@account.com') }

        describe 'should sign the user in' do
          it { should have_link('Sign out') }
          it { should have_selector('div.alert',
            text: 'Welcome! You have signed up successfully.') }
        end

        describe 'should have same account id as account created' do
          specify { expect(created_user.account_id).to eq Account.first.id }
        end
      end
    end
  end
end
