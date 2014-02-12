require 'spec_helper'
require 'pp'
include Warden::Test::Helpers
Warden.test_mode!

describe 'User pages' do
  let!(:account) { FactoryGirl.create(:account, name: 'Another Account') }
  let!(:another_account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:location_too) do
    FactoryGirl.create(:location,
                       name: 'Another Location',
                       account_id: another_account.id)
  end

  let!(:position) { FactoryGirl.create(:position, account_id: account.id) }
  let!(:position_too) do
    FactoryGirl.create(:position,
                       name: 'Another position',
                       account_id: another_account.id)
  end

  let!(:user) do
    FactoryGirl.create(:user,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id,
                       notes: 'hello')
  end

  let!(:admin) do
    FactoryGirl.create(:admin,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  let!(:cert1) do
    FactoryGirl.create(:certification_name,
                       account_id: account.id, name: 'CPR/AED1')
  end

  let!(:cert2) do
    FactoryGirl.create(:certification_name,
                       account_id: another_account.id,
                       name: 'CPR/AED2')
  end

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
        select account.name,             from: 'Account'
        fill_in 'First Name',            with: 'First'
        fill_in 'Preferred Name',        with: 'Dubbs'
        fill_in 'Last Name',             with: 'Last'
        fill_in 'Phone Number',          with: '1234'
        fill_in 'Email',                 with: 'user@example.com'
        fill_in 'Password',              with: 'foobar77'
        fill_in 'Password Confirmation', with: 'foobar77'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('user@example.com') }

        it { should have_link('Sign out') }
        it { should have_selector('div.alert') }
      end
    end
  end

  describe 'user profile' do
    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:certification,
                         certification_name_id: cert1.id,
                         user_id: user.id)
      FactoryGirl.create(:certification,
                         certification_name_id: cert2.id,
                         user_id: user.id)
      visit user_path(user)
    end

    it 'should list the certifications in the correct order' do
      user.certifications.first.certification_name_id.should <
      user.certifications.second.certification_name_id
    end

    describe 'as admin' do
      before do
        Warden.test_reset!
        login_as(admin, scope: :user)
        visit user_path(user)
      end

      it { should have_selector('h4', text: 'Notes') }
      it { should have_link('Edit', edit_user_path(user)) }

      describe 'should display notes' do
        it { should have_content('hello') }
      end
    end

    describe 'as non-admin' do
      it { should_not have_selector('h4', text: 'Notes') }
    end
  end

  describe 'index' do
    let(:bob) { User.find_by_email('bob@example.com') }

    before do
      login_as(admin, scope: :user)

      FactoryGirl.create(:user,
                         first_name: 'Bob',
                         email: 'bob@example.com',
                         location_id: location.id,
                         position_id: position.id,
                         account_id: account.id)

      visit users_path
    end

    it { should have_title('Users') }
  end

  describe 'add user account' do
    before { visit new_user_path }

    it { should have_content('Create New User') }
    it { should have_title('Create New User') }
  end

  describe 'edit' do
    before do
      login_as(user, scope: :user)
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content('Update My Profile') }
      it { should have_title('Edit user') }

      describe 'as non-admin' do

        describe 'should not see certifications' do
          it { should_not have_selector('h4', text: 'Certifications') }
          it { should have_no_selector('label', text: 'Issue Date') }

          it { should have_no_selector('label', text: 'Expiration Date') }

          it { should have_no_selector('label', text: 'Attachment') }
        end

        describe 'should not see other admin fields' do
          it { should have_no_selector('label', text: 'Location') }
          it { should have_no_selector('label', text: 'Position') }
          it { should have_no_selector('label', text: 'Employee ID') }
          it { should have_no_selector('label', text: 'Grouping') }
          it { should have_no_selector('label', text: 'Pay Rate') }
          it { should have_no_selector('label', text: 'Date of Hire') }
          it { should have_no_selector('label', text: 'Notes') }
        end

        describe 'with invalid information' do
          before { click_button 'Save Changes' }

          it { should have_content('error') }
        end

        describe 'with valid information' do
          let(:new_first_name)  { 'NewFirstName' }
          let(:new_email)       { 'newEmail@example.com' }

          before do
            # Basic User Information
            fill_in 'First Name',            with: new_first_name
            fill_in 'Preferred Name',        with: 'dubbs'
            fill_in 'Last Name',             with: 'Last'
            fill_in 'Phone Number',          with: '720-387-9691'
            fill_in 'Email',                 with: new_email
            fill_in 'Password',              with: 'foobar77'
            fill_in 'Password Confirmation', with: 'foobar77'

            # Additional User Information
            select 'September',           from: 'user_date_of_birth_2i'
            select '15',                  from: 'user_date_of_birth_3i'
            select '1992',                from: 'user_date_of_birth_1i'
            select('M',                   from: 'Sex')
            fill_in 'Address 1',          with: '14270 W Warren Dr.'
            fill_in 'Address 2',          with: 'Unit B'
            fill_in 'City',               with: 'Lakewood'
            select('CO',                  from: 'State')
            fill_in 'Zipcode',            with: '80228'
            # skip avatar

            # Sizing Information
            select('M',                   from: 'Shirt Size')
            select('M',                   from: 'Shorts Size')
            select('28',                  from: 'user[femalesuit]')

            # Emergency Contact Information
            fill_in 'Emergency First Name',    with: 'my'
            fill_in 'Emergency Last Name',     with: 'mom'
            fill_in 'Emergency Phone #',    with: '303-999-8765'

            # Admin User Information
            # No admin information

            click_button 'Save Changes'
          end

          it { should have_title(full_title(new_first_name)) }
          it { should have_selector('div.alert') }
          it { should have_link('Sign out', destroy_user_session_path) }
          specify { expect(current_path).to eq user_path(user) }
          specify { expect(user.reload.first_name).to eq new_first_name }
          specify { expect(user.reload.email).to eq new_email.downcase }
          specify { expect(user.reload.location.id).to eq location.id }
          specify { expect(user.reload.position.id).to eq position.id }
        end
      end

      describe 'as admin' do
        before do
          login_as(admin, scope: :user)
          FactoryGirl.create(:certification,
                             certification_name_id: cert1.id,
                             user_id: user.id)
          FactoryGirl.create(:certification,
                             certification_name_id: cert2.id,
                             user_id: user.id)
          visit edit_user_path(user)
        end

        describe 'should see certs' do
          it { should have_selector('h4', text: 'Certifications') }
          it { should have_selector('label', text: 'Issue Date') }
          it { should have_selector('label', text: 'Expiration Date') }

          it { should have_selector('label', text: 'Attachment') }
        end

        describe 'should see other admin fields' do
          it { should have_selector('label', text: 'Location') }
          it { should have_selector('label', text: 'Position') }
          it { should have_selector('label', text: 'Employee ID') }
          it { should have_selector('label', text: 'Grouping') }
          it { should have_selector('label', text: 'Pay Rate') }
          it { should have_selector('label', text: 'Date of Hire') }
          it { should have_selector('label', text: 'Notes') }
        end

        describe 'should have certification names for current users account' do
          it { should have_selector('option', text: cert1.name) }
          it { should_not have_selector('option', text: cert2.name) }
        end

        describe 'should only have locations for current users account' do
          it { should have_selector('option', text: location.name) }
          it { should_not have_selector('option', text: location_too.name) }
        end

        describe 'should only have positions for current users account' do
          it { should have_selector('option', text: position.name) }
          it { should_not have_selector('option', text: position_too.name) }
        end

        describe 'with invalid information' do
          before { click_button 'Save Changes' }

          it { should have_content('error') }
        end

        describe 'with valid information' do
          let(:new_first_name)  { 'NewFirstName' }
          let(:new_email) { 'newEmail@example.com' }

          before do
            # Basic User Information
            fill_in 'First Name',            with: new_first_name
            fill_in 'Preferred Name',        with: 'dubbs'
            fill_in 'Last Name',             with: 'Last'
            fill_in 'Phone Number',          with: '720-387-9691'
            fill_in 'Email',                 with: new_email
            fill_in 'Password',              with: 'foobar77'
            fill_in 'Password Confirmation', with: 'foobar77'

            # Additional User Information
            select 'September',           from: 'user_date_of_birth_2i'
            select '15',                  from: 'user_date_of_birth_3i'
            select '1992',                from: 'user_date_of_birth_1i'
            select('M',                   from: 'Sex')
            fill_in 'Address 1',          with: '14270 W Warren Dr.'
            fill_in 'Address 2',          with: 'Unit B'
            fill_in 'City',               with: 'Lakewood'
            select('CO',                  from: 'State')
            fill_in 'Zipcode',            with: '80228'

            # skip avatar

            # Sizing Information
            select('M',                   from: 'Shirt Size')
            select('M',                   from: 'Shorts Size')
            select('28',                  from: 'user[femalesuit]')

            # Emergency Contact Information
            fill_in 'Emergency First Name', with: 'my'
            fill_in 'Emergency Last Name',  with: 'mom'
            fill_in 'Emergency Phone #',    with: '303-999-8765'

            # Admin User Information
            select location.name,         from: 'user[location_id]'
            select position.name,         from: 'user[position_id]'
            fill_in 'Employee ID',        with: '1313'
            fill_in 'Grouping',           with: 'West'
            select 'September',           from: 'user_date_of_hire_2i'
            select '15',                  from: 'user_date_of_hire_3i'
            select '2013',                from: 'user_date_of_hire_1i'
            fill_in 'Pay Rate',           with: '9.50'

            click_button 'Save Changes'
          end

          it { should have_title(full_title(new_first_name)) }
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', destroy_user_session_path) }
          specify { expect(current_path).to eq user_path(user) }
          specify { expect(user.reload.first_name).to eq new_first_name }
          specify { expect(user.reload.email).to eq new_email.downcase }
          specify { expect(user.reload.location.id).to eq location.id }
          specify { expect(user.reload.position.id).to eq position.id }
        end
      end
    end
  end
end
