require 'spec_helper'

describe 'Time Off Request pages' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }

  let!(:admin) do
    FactoryGirl.create(:admin, account_id: account.id, location_id: location.id)
  end

  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id, location_id: location.id)
  end

  subject { page }

  describe 'index' do
    before do
      login_as(admin, scope: :user)
      visit time_off_requests_path
    end

    it { should have_selector('h1', text: 'Time Off Requests') }
    it { should have_title(full_title('Time Off Requests')) }
    it { should have_link('New Request', new_time_off_request_path) }

    it { should have_selector('th', text: 'Employee') }
    it { should have_selector('th', text: 'Date Submitted') }
    it { should have_selector('th', text: 'Start Date') }
    it { should have_selector('th', text: 'End Date') }
    it { should have_content('report.location.name') }
    it { should have_content("report.created_at | date:'M/d/yy h:mm a'") }
    it { should have_content('report.user.last_name') }
    it { should have_content('report.user.first_name') }
    it { should have_content('report.report_filed | booleanToWords') }
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_time_off_request_path
    end

    describe 'time off request' do
      let(:reason) { 'Example time_off_request reason' }
      let(:submit) { 'Submit' }

      it { should have_selector('h1', text: 'New Time Off Request') }
      it { should have_title(full_title('New Time Off Request')) }
      it { should have_content('Start Date') }
      it { should have_content('End Date') }
      it { should have_content('Reason') }

      describe 'with valid information' do
        before do
          fill_in 'Start Date', with: '6/21/2012'
          fill_in 'Start Time', with: '12:00pm'
          fill_in 'End Date', with: '6/26/2012'
          fill_in 'End Time', with: '5:00pm'
          fill_in 'Reason', with: reason
        end

        it 'should create a time off request' do
          expect { click_button submit }.to change(TimeOffRequest, :count).by(1)
        end

        describe 'redirect to index' do
          before { click_button submit }
          it { current_path.should eq time_off_request_path(TimeOffRequest.last) }
          it { should have_content('Time Off Request was successfully created.') }
        end
      end

      describe 'with invalid information' do
        before do
          check 'All Day'
        end

        it 'should not create a time off request record' do
          expect { click_button submit }.to_not change(TimeOffRequest, :count).by(1)
        end
      end
    end
  end

  describe 'edit' do
    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:time_off_request,
                         user_id: user.id)
      visit edit_time_off_request_path(TimeOffRequest.last)
    end

    describe 'time off request' do
      let(:edited_content) { 'edit content' }
      let(:submit) { 'Save Changes' }

      it { should have_selector('h1', text: 'Edit Time Off Request') }
      it { should have_title(full_title('Edit Time Off Request')) }
      it { should have_content('Start Date') }
      it { should have_content('End Date') }
      it { should have_content('All Day') }

      describe 'with valid information' do
        before do
          fill_in 'Start Date', with: '6/21/2012'
          fill_in 'Start Time', with: '12:00pm'
          fill_in 'End Date', with: '6/26/2012'
          fill_in 'End Time', with: '5:00pm'
          fill_in 'Reason', with: reason
        end

        it 'should update the time off request' do
          expect { click_button submit }.to_not change(TimeOffRequest, :count).by(1)
        end

        describe 'redirect to show page' do
          before { click_button submit }
          it { current_path.should eq time_off_request_path(TimeOffRequest.last) }
          it { should have_content('Time Off Request was successfully updated.') }
        end
      end

      describe 'with invalid information' do
        before do
          check 'All Day'
        end

        describe 'redirect to edit page' do
          before { click_button submit }
          it { current_path.should eq edit_time_off_request_path(TimeOffRequest.last) }
          it { should have_content("can't be blank")}
        end
      end
    end
  end

  describe 'show' do

    before do
      login_as(admin, scope: :user)
      FactoryGirl.create(:time_off_request,
                         user_id: user.id)
      visit time_off_request_path(TimeOffRequest.last)
    end

    describe 'time_off_request' do
      it { should have_selector('h1', text: 'Time Off Request') }
      it { should have_title(full_title('Time Off Request')) }
      it { should have_link('Back', time_off_requests_path) }

      describe 'attributes' do
        it { should have_selector('th', text: 'Employee') }
        it { should have_selector('th', text: 'Date Submitted') }
        it { should have_selector('th', text: 'Start Date') }
        it { should have_selector('th', text: 'End Date') }
        it { should have_selector('th', text: 'Approved') }
        it { should have_selector('th', text: 'Approved By') }
        it { should have_selector('th', text: 'Approved At') }

        it do should have_selector('td',
                                   text: user.first_name) end
        it do should have_selector('td',
                                   text: user.last_name) end
      end
    end
  end
end
