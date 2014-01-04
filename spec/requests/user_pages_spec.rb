require 'spec_helper'

describe 'User pages' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, location_id: location.id,
    position_id: position.id, account_id: account.id) }

  subject { page }

  describe 'index' do

    before do
      sign_in user
      FactoryGirl.create(:user, first_name: 'Bob', email: 'bob@example.com',
        location_id: location.id, position_id: position.id)
      FactoryGirl.create(:user, first_name: 'Ben', email: 'ben@example.com',
        location_id: location.id, position_id: position.id)
      visit users_path
    end

    it { should have_title('Users') }
    it { should have_content('Users') }

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
      it { should have_content('Update My Profile') }
      it { should have_title('Edit user') }
    end

    describe 'with invalid information' do
      before { click_button 'Save Changes' }

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
        select 'September', from: 'user_date_of_birth_2i'
        select '15', from: 'user_date_of_birth_3i'
        select '1992', from: 'user_date_of_birth_1i'
        select 'August', from: 'user_date_of_hire_2i'
        select '15', from: 'user_date_of_hire_3i'
        select '2012', from: 'user_date_of_hire_1i'
        select location.name, from: 'user[location_id]'
        select position.name,  from: 'user[position_id]'
        select('M', from: 'Shirt Size')
        select('M', from: 'Shorts Size')
        select('28', from: 'user[femalesuit]')
        click_button 'Save Changes'
      end

      it { should have_title(full_title(new_first_name)) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.first_name).to eq new_first_name }
      specify { expect(user.reload.email).to eq new_email.downcase }
      specify { expect(user.reload.location.id).to eq location.id}
      specify { expect(user.reload.position.id).to eq position.id}
    end
  end

  describe 'signup' do

    before do
      FactoryGirl.create(:location, name: 'newlocation')
      FactoryGirl.create(:position, name: 'newposition')
      visit signup_path
    end

    let(:submit) { 'Create Account' }

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

        select 'September', from: 'user_date_of_birth_2i'
        select '8', from: 'user_date_of_birth_3i'
        select '1992', from: 'user_date_of_birth_1i'

        select 'August', from: 'user_date_of_hire_2i'
        select '15', from: 'user_date_of_hire_3i'
        select '2012', from: 'user_date_of_hire_1i'

        select 'account_name', from: 'user[account_id]'
        select 'newlocation', from: 'user[location_id]'
        select 'newposition',  from: 'user[position_id]'
        select('M', from: 'Shirt Size')
        select('M', from: 'Shorts Size')
        select('28', from: 'user[femalesuit]')
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success',
          text: 'This account has been successfully created!') }
      end
    end
  end

  require File.dirname(__FILE__) + '/../spec_helper'
end
