require 'spec_helper'

describe 'User pages' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:another_account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:another_location) { FactoryGirl.create(:location,
                                               name: 'Another Location',
                                               account_id: another_account.id) }
  let!(:position) { FactoryGirl.create(:position, account_id: account.id) }
  let!(:another_position) { FactoryGirl.create(:position,
                                               name: 'Another position',
                                               account_id: another_account.id) }
  let!(:user) { FactoryGirl.create(:user,
                                   location_id: location.id,
                                   position_id: position.id,
                                   account_id: account.id) }
  let!(:admin) { FactoryGirl.create(:admin,
                                    location_id: location.id,
                                    position_id: position.id,
                                    account_id: account.id) }

  let!(:cert1) { FactoryGirl.create(:certification_name,
                                    account_id: account.id, name: 'CPR/AED1') }
  let!(:cert2) { FactoryGirl.create(:certification_name,
                                    account_id: another_account.id,
                                    name: 'CPR/AED2') }

  subject { page }

  describe 'signup' do
    before do
      sign_in admin
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
        fill_in 'First Name',       with: 'First'
        fill_in 'Preferred Name',   with: 'Dubbs'
        fill_in 'Last Name',        with: 'Last'
        fill_in 'Phone Number',     with: '1234'
        fill_in 'Email',            with: 'user@example.com'
        fill_in 'Password',         with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('user@example.com') }

        it 'should have same account_id as current_user' do
          created_user.account_id.should eq(user.account_id)
        end

        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success') }
      end
    end
  end

  describe 'user profile' do
    before do
      sign_in user
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
  end

  describe 'index' do
    let(:bob) { User.find_by_email('bob@example.com') }

    before do
      sign_in admin

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

      describe 'as non-admin' do

        describe 'should not see certifications' do
          it { should_not have_selector('h4', text: 'Certifications') }
          it { should have_no_field('user_certifications_attributes_0_issue_date_1i') }
          it { should have_no_field('user_certifications_attributes_0_issue_date_2i') }
          it { should have_no_field('user_certifications_attributes_0_issue_date_3i') }

          it { should have_no_field('user_certifications_attributes_0_expiration_date_1i') }
          it { should have_no_field('user_certifications_attributes_0_expiration_date_2i') }
          it { should have_no_field('user_certifications_attributes_0_expiration_date_3i') }

          it { should have_no_field('user_certifications_attributes_0_attachment') }
        end

        describe 'should not see other admin fields' do
          it { should have_no_field('user_location_id') }
          it { should have_no_field('user_position_id') }
          it { should have_no_field('user_employee_id') }
          it { should have_no_field('user_grouping') }
          it { should have_no_field('user_payrate') }
          it { should have_no_field('user_date_of_hire_1i') }
          it { should have_no_field('user_date_of_hire_2i') }
          it { should have_no_field('user_date_of_hire_3i') }
          it { should have_no_field('Notes') }
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
            fill_in 'First Name',         with: new_first_name
            fill_in 'Preferred Name',     with: 'dubbs'
            fill_in 'Last Name',          with: 'Last'
            fill_in 'Phone Number',       with: '720-387-9691'
            fill_in 'Email',              with: new_email
            fill_in 'Password',           with: 'foobar'
            fill_in 'Confirm Password',   with: 'foobar'

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
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', href: signout_path) }
          specify { expect(user.reload.first_name).to eq new_first_name }
          specify { expect(user.reload.email).to eq new_email.downcase }
          specify { expect(user.reload.location.id).to eq location.id }
          specify { expect(user.reload.position.id).to eq position.id }
        end
      end

      describe 'as admin' do
        before do
          sign_in admin
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
          it { should have_field('user_certifications_attributes_0_issue_date_1i') }
          it { should have_field('user_certifications_attributes_0_issue_date_2i') }
          it { should have_field('user_certifications_attributes_0_issue_date_3i') }

          it { should have_field('user_certifications_attributes_0_expiration_date_1i') }
          it { should have_field('user_certifications_attributes_0_expiration_date_2i') }
          it { should have_field('user_certifications_attributes_0_expiration_date_3i') }

          it { should have_field('user_certifications_attributes_0_attachment') }
        end

        describe 'should see other admin fields' do
          it { should have_field('user_location_id') }
          it { should have_field('user_position_id') }
          it { should have_field('user_employee_id') }
          it { should have_field('user_grouping') }
          it { should have_field('user_payrate') }
          it { should have_field('user_date_of_hire_1i') }
          it { should have_field('user_date_of_hire_2i') }
          it { should have_field('user_date_of_hire_3i') }
          it { should have_field('Notes') }
        end

        describe 'should have certification names for current users account' do
          it { should have_selector('option', text: cert1.name) }
          it { should_not have_selector('option', text: cert2.name) }
        end

        describe 'should only have locations for current users account' do
          it { should have_selector('option', text: location.name) }
          it { should_not have_selector('option', text: another_location.name) }
        end

        describe 'should only have positions for current users account' do
          it { should have_selector('option', text: position.name) }
          it { should_not have_selector('option', text: another_position.name) }
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
            fill_in 'First Name',         with: new_first_name
            fill_in 'Preferred Name',     with: 'dubbs'
            fill_in 'Last Name',          with: 'Last'
            fill_in 'Phone Number',       with: '720-387-9691'
            fill_in 'Email',              with: new_email
            fill_in 'Password',           with: 'foobar'
            fill_in 'Confirm Password',   with: 'foobar'

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
            select location.name,         from: 'user[location_id]'
            select position.name,         from: 'user[position_id]'
            fill_in 'Employee ID',    with: '1313'
            fill_in 'Grouping',    with: 'West'
            select 'September',           from: 'user_date_of_hire_2i'
            select '15',                  from: 'user_date_of_hire_3i'
            select '2013',                from: 'user_date_of_hire_1i'
            fill_in 'Pay Rate',    with: '9.50'

            click_button 'Save Changes'
          end

          it { should have_title(full_title(new_first_name)) }
          it { should have_selector('div.alert.alert-success') }
          it { should have_link('Sign out', href: signout_path) }
          specify { expect(user.reload.first_name).to eq new_first_name }
          specify { expect(user.reload.email).to eq new_email.downcase }
          specify { expect(user.reload.location.id).to eq location.id }
          specify { expect(user.reload.position.id).to eq position.id }
        end
      end
    end
  end
end
