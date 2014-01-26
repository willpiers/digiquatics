require 'spec_helper'

describe 'Account pages' do

  subject { page }

  describe 'signup' do
    before do
      visit signup_path
    end

    let(:submit) { 'Create Account' }

    describe 'with invalid information' do
      it 'should not create an account' do
        expect { click_button submit }.not_to change(Account, :count)
      end

      it 'also should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'Organization Name',     with: 'City of Lakewood'
        fill_in 'First Name',       with: 'First'
        fill_in 'Preferred Name',   with: 'Dubbs'
        fill_in 'Last Name',        with: 'Last'
        fill_in 'Phone Number',     with: '1234'
        fill_in 'Email',            with: 'new@account.com'
        fill_in 'Password',         with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'

        select '(GMT-07:00) Mountain Time (US & Canada)', from: 'Time zone'
      end

      it 'should create an account' do
        expect { click_button submit }.to change(Account, :count).by(1)
      end
      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the account and user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('new@account.com') }
        let(:created_account) { Account.find_by_name('City of Lakewood') }

        describe 'should sign the user in' do
          it { should have_link('Sign out') }
          it { should have_selector('div.alert.alert-success') }
        end

        describe 'user should have same account id as account created' do
          specify { expect(created_user.account_id).to eq created_account.id }
        end
      end
    end
  end
end
