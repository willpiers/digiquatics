require 'spec_helper'

describe 'Slide Inspection pages' do
  let!(:account) { FactoryGirl.create(:account) }

  let!(:admin) do
    FactoryGirl.create(:admin, account_id: account.id)
  end

  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id)
  end

  let!(:slide) { FactoryGirl.create(:slide) }

  let!(:slide_inspection) do
    FactoryGirl.create(:slide_inspection, slide_id: slide.id, user_id: user.id)
  end

  subject { page }

  describe 'index' do
    before do
      login_as(admin, scope: :user)

      visit slide_inspections_path
    end

    it { should have_selector('h1', text: 'Slide Inspections') }
    it { should have_title(full_title('Slide Inspections')) }
    it { should have_link('New Slide Inspection', new_slide_inspection_path) }

    describe 'should list the slide inspections' do
      it { should have_selector('th', text: 'Slide') }
      it { should have_selector('th', text: 'Completed By') }
      it { should have_selector('th', text: 'Date') }
      it { should have_selector('th', text: 'All OK?') }
    end
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_slide_inspection_path
    end

    describe 'slide inspection' do
      it { should have_content('New Slide Inspection') }
      it { should have_title('New Slide Inspection') }


      describe 'with valid information' do
        let(:submit) { 'Create Slide inspection' }

        before do
          select slide.name, from: 'slide_inspection_slide_id'
          # fill_in 'chemical_record_free_chlorine_ppm', with: 2
        end

        it 'should create a slide inspection record' do
          expect { click_button submit }.to change(SlideInspection, :count).by(1)
        end
      end
    end
  end

  describe 'show' do
    before do
      login_as(user, scope: :user)
      visit slide_inspection_path(slide_inspection)
    end

    describe 'slide inspection' do
      it { should have_content('Slide Inspection') }
      it { should have_title(full_title('Slide Inspection')) }

      describe 'attributes' do
        it { should have_selector('th', text: 'Slide') }
        it { should have_selector('th', text: 'Completed By') }
        it { should have_selector('th', text: 'Date') }
        it { should have_selector('th', text: 'All OK?') }
        it { should have_selector('td', text: slide.name) }
        it { should have_selector('td',
                                  text: slide_inspection.user.first_name) }
        it { should have_selector('td',
                                  text: slide_inspection.user.last_name) }
      end
    end
  end

  # describe 'edit' do
  #   before do
  #     login_as(user, scope: :user)
  #     visit edit_user_path(user)
  #   end

  #   describe 'page' do
  #     it { should have_content('Update My Profile') }
  #     it { should have_title('Edit Employee') }

  #     describe 'as non-admin' do

  #       describe 'should not see certifications' do
  #         it { should_not have_selector('h4', text: 'Certifications') }
  #         it { should have_no_selector('label', text: 'Issue Date') }

  #         it { should have_no_selector('label', text: 'Expiration Date') }

  #         it { should have_no_selector('label', text: 'Attachment') }
  #       end

  #       describe 'should not see other admin fields' do
  #         it { should have_no_selector('label', text: 'Location') }
  #         it { should have_no_selector('label', text: 'Position') }
  #         it { should have_no_selector('label', text: 'Employee ID') }
  #         it { should have_no_selector('label', text: 'Grouping') }
  #         it { should have_no_selector('label', text: 'Pay Rate') }
  #         it { should have_no_selector('label', text: 'Date of Hire') }
  #         it { should have_no_selector('label', text: 'Notes') }
  #       end

  #       describe 'with invalid information' do
  #         before do
  #           fill_in('Password *', with: 'foo', exact: true)
  #           click_button 'Save Changes'
  #         end
  #       end

  #       describe 'with valid information' do
  #         let(:new_first_name)  { 'NewFirstName' }
  #         let(:new_email)       { 'newEmail@example.com' }

  #         before do
  #           # Basic User Information
  #           fill_in 'First Name *',       with: new_first_name, exact: true
  #           # fill_in 'user_nickname',    with: 'Bobs'
  #           fill_in 'Last Name *',        with: 'Last', exact: true
  #           fill_in 'Phone Number *',     with: '720-387-9691', exact: true
  #           fill_in 'Email *',            with: new_email, exact: true
  #           fill_in 'Password *',         with: 'foobar77', exact: true
  #           fill_in 'Confirm Password *', with: 'foobar77', exact: true

  #           # Additional User Information
  #           select 'September',           from: 'user_date_of_birth_2i'
  #           select '15',                  from: 'user_date_of_birth_3i'
  #           select '1992',                from: 'user_date_of_birth_1i'
  #           select('M',                   from: 'Sex')
  #           fill_in 'Address 1',          with: '14270 W Warren Dr.'
  #           fill_in 'Address 2',          with: 'Unit B'
  #           fill_in 'City',               with: 'Lakewood'
  #           select('CO',                  from: 'State')
  #           fill_in 'Zipcode',            with: '80228'
  #           # skip avatar

  #           # Sizing Information
  #           select('M',                   from: 'user_shirt_size')
  #           select('M',                   from: 'user_suit_size')
  #           select('28',                  from: 'user_femalesuit')

  #           # Emergency Contact Information
  #           fill_in 'Emergency First Name',    with: 'my'
  #           fill_in 'Emergency Last Name',     with: 'mom'
  #           fill_in 'Emergency Phone #',    with: '303-999-8765'

  #           # Admin User Information
  #           # No admin information

  #           click_button 'Save Changes'
  #         end

  #         it { should have_title(full_title(new_first_name)) }
  #         it { should have_selector('div.alert') }
  #         it { should have_link('Sign out', destroy_user_session_path) }
  #         specify { expect(current_path).to eq user_path(user) }
  #         specify { expect(user.reload.first_name).to eq new_first_name }
  #         specify { expect(user.reload.email).to eq new_email.downcase }
  #         specify { expect(user.reload.location.id).to eq location.id }
  #         specify { expect(user.reload.position.id).to eq position.id }
  #       end
  #     end

  #     describe 'as admin' do
  #       before do
  #         login_as(admin, scope: :user)
  #         FactoryGirl.create(:certification,
  #                            certification_name_id: cert1.id,
  #                            user_id: user.id)
  #         FactoryGirl.create(:certification,
  #                            certification_name_id: cert2.id,
  #                            user_id: user.id)
  #         visit edit_user_path(user)
  #       end

  #       describe 'should see certs' do
  #         it { should have_selector('h4', text: 'Certifications') }
  #         it { should have_selector('label', text: 'Issue date') }
  #         it { should have_selector('label', text: 'Expiration date') }
  #         it { should have_selector('label', text: 'Attachment') }
  #       end

  #       describe 'should see other admin fields' do
  #         it { should have_selector('label', text: 'Location') }
  #         it { should have_selector('label', text: 'Position') }
  #         it { should have_selector('label', text: 'Employee ID') }
  #         it { should have_selector('label', text: 'Grouping') }
  #         it { should have_selector('label', text: 'Pay Rate') }
  #         it { should have_selector('label', text: 'Date of hire') }
  #         it { should have_selector('label', text: 'Notes') }
  #       end

  #       describe 'should have certification names for current users account' do
  #         it { should have_selector('option', text: cert1.name) }
  #         it { should_not have_selector('option', text: cert2.name) }
  #       end

  #       describe 'should only have locations for current users account' do
  #         it { should have_selector('option', text: location.name) }
  #         it { should_not have_selector('option', text: location_too.name) }
  #       end

  #       describe 'should only have positions for current users account' do
  #         it { should have_selector('option', text: position.name) }
  #         it { should_not have_selector('option', text: position_too.name) }
  #       end

  #       describe 'with invalid information' do
  #         before do
  #           fill_in 'Password *', with: 'foo', exact: true
  #           click_button 'Save Changes'
  #         end

  #       end

  #       describe 'with valid information' do
  #         let(:new_first_name)  { 'NewFirstName' }
  #         let(:new_email) { 'newEmail@example.com' }

  #         before do
  #           # Basic User Information
  #           fill_in 'First Name *',       with: new_first_name, exact: true
  #           # fill_in 'user_nickname',    with: 'Bobs'
  #           fill_in 'Last Name *',        with: 'Last', exact: true
  #           fill_in 'Phone Number *',     with: '720-387-9691', exact: true
  #           fill_in 'Email *',            with: new_email, exact: true
  #           fill_in 'Password *',         with: 'foobar77', exact: true
  #           fill_in 'Confirm Password *', with: 'foobar77', exact: true

  #           # Additional User Information
  #           select 'September',           from: 'user_date_of_birth_2i'
  #           select '15',                  from: 'user_date_of_birth_3i'
  #           select '1992',                from: 'user_date_of_birth_1i'
  #           select('M',                   from: 'Sex')
  #           fill_in 'Address 1',          with: '14270 W Warren Dr.'
  #           fill_in 'Address 2',          with: 'Unit B'
  #           fill_in 'City',               with: 'Lakewood'
  #           select('CO',                  from: 'State')
  #           fill_in 'Zipcode',            with: '80228'

  #           # skip avatar

  #           # Sizing Information
  #           select('M',                   from: 'user_shirt_size')
  #           select('M',                   from: 'user_suit_size')
  #           select('28',                  from: 'user_femalesuit')

  #           # Emergency Contact Information
  #           fill_in 'Emergency First Name', with: 'my'
  #           fill_in 'Emergency Last Name',  with: 'mom'
  #           fill_in 'Emergency Phone #',    with: '303-999-8765'

  #           # Admin User Information
  #           select location.name,         from: 'user_location_id'
  #           select position.name,         from: 'user_position_id'
  #           fill_in 'Employee ID',        with: '1313'
  #           fill_in 'Grouping',           with: 'West'
  #           select 'September',           from: 'user_date_of_hire_2i'
  #           select '15',                  from: 'user_date_of_hire_3i'
  #           select '2013',                from: 'user_date_of_hire_1i'
  #           fill_in 'Pay Rate',           with: '9.50'

  #           click_button 'Save Changes'
  #         end

  #         it { should have_title(full_title(new_first_name)) }
  #         it { should have_selector('div.alert.alert-success') }
  #         it { should have_link('Sign out', destroy_user_session_path) }
  #         specify { expect(current_path).to eq user_path(user) }
  #         specify { expect(user.reload.first_name).to eq new_first_name }
  #         specify { expect(user.reload.email).to eq new_email.downcase }
  #         specify { expect(user.reload.location.id).to eq location.id }
  #         specify { expect(user.reload.position.id).to eq position.id }
  #       end
  #     end
  #   end
  # end
end
