require 'spec_helper'

describe 'User pages' do
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, location_id: location.id, position_id: position.id) }

  subject { page }

  describe 'index' do
    
    before do
      sign_in user
      FactoryGirl.create(:user, first_name: 'Bob', email: 'bob@example.com', location_id: location.id, position_id: position.id)
      FactoryGirl.create(:user, first_name: 'Ben', email: 'ben@example.com', location_id: location.id, position_id: position.id)
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it 'should list each user' do
      user = User.find_by_email('bob@example.com')
      page.should have_content(user.first_name)
      page.should have_content(user.last_name)
      page.should have_content(user.sex)
      page.should have_content(user.location.name)
      page.should have_content(user.position.name)
      page.should have_content(user.email)
      page.should have_content(user.phone_number)
    end
  end

  describe 'profile page' do
    before { visit signup_path }

    it { should have_content('First Name') }
    it { should have_title('Create New User') }
  end

  describe 'add account' do
    before { visit signup_path }

    it { should have_content('Create New User') }
    it { should have_title('Create New User') }
  end

  describe 'edit' do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content('Update your profile') }
      it { should have_title('Edit user') }
    end

    describe 'with invalid information' do
      before { click_button 'Save changes' }

      it { should have_content('error') }
    end

    describe 'with valid information' do
      let(:new_first_name)  { 'NewFirstName' }
      let(:new_email) { 'newEmail@example.com' }

      before do
        fill_in 'First Name',   with: new_first_name
        fill_in 'Last Name',    with: 'Last'
        fill_in 'Phone Number',   with: '1234'
        fill_in 'Email',        with: new_email
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'
        select('M', from: 'Sex')
        fill_in 'Date of Birth', with: '1992-09-15'
        fill_in 'Date of Hire', with: '2012-08-15'
        fill_in 'Location',   with: location.id
        fill_in 'Position',  with: position.id
        select('M', from: 'Shirt Size')
        select('M', from: 'Shorts Size')
        select('28', from: 'One Piece Size (F)')
        click_button 'Save changes'
      end

      it { should have_title(full_title(new_first_name)) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to eq new_first_name }
      specify { expect(user.reload.email).to eq new_email.downcase }
    end
  end

  describe 'signup' do

    before { visit signup_path }

    let(:submit) { 'Create/Save Account' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do

      before do
        fill_in 'First Name',   with: 'First'
        fill_in 'Last Name',    with: 'Last'
        fill_in 'Phone Number',   with: '1234'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'
        select('M', from: 'Sex')
        fill_in 'Date of Birth', with: '1992-09-15'
        fill_in 'Date of Hire', with: '2012-08-15'
        fill_in 'Location',   with: location.id
        fill_in 'Position',  with: position.id
        select('M', from: 'Shirt Size')
        select('M', from: 'Shorts Size')
        select('28', from: 'One Piece Size (F)')
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success', text: 'This account has been successfully created!') }
      end
    end
  end

  require File.dirname(__FILE__) + '/../spec_helper'
end
