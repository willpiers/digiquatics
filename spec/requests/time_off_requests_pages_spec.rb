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
    it { should have_link('View Processed', archived_time_off_requests_path) }

    it { should have_selector('th', text: 'Last Name') }
    it { should have_selector('th', text: 'First Name') }
    it { should have_selector('th', text: 'Name') }
    it { should have_selector('th', text: 'Start Date') }
    it { should have_selector('th', text: 'End Date') }
    it { should have_selector('th', text: 'Reason') }
  end

  describe 'processed time off requests' do
    before do
      login_as(admin, scope: :user)
      visit archived_time_off_requests_path
    end

    it { should have_selector('h1', text: 'Processed Time Off Requests') }
    it { should have_title(full_title('Processed Time Off Requests')) }
    it { should have_link('Queue', time_off_requests_path) }

    it { should have_selector('th', text: 'Last Name') }
    it { should have_selector('th', text: 'First Name') }
    it { should have_selector('th', text: 'Name') }
    it { should have_selector('th', text: 'Start Date') }
    it { should have_selector('th', text: 'End Date') }
    it { should have_selector('th', text: 'Reason') }
    it { should have_selector('th', text: 'Date Submitted') }
    it { should have_selector('th', text: 'Status') }
    it { should have_selector('th', text: 'Processed By') }
    it { should have_selector('th', text: 'Processed On') }
  end

  describe 'my time off requests' do
    before do
      login_as(admin, scope: :user)
      visit my_time_off_requests_path
    end

    it { should have_selector('h1', text: 'My Time Off Requests') }
    it { should have_title(full_title('My Time Off Requests')) }
    it { should have_link('Add Request', new_time_off_request_path) }

    it { should have_selector('th', text: 'Start Date') }
    it { should have_selector('th', text: 'End Date') }
    it { should have_selector('th', text: 'Reason') }
    it { should have_selector('th', text: 'Status') }
    it { should have_selector('th', text: 'Date Submitted') }
    it { should have_selector('th', text: 'Processed By') }
    it { should have_selector('th', text: 'Processed On') }
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
      it { should have_content('Start Date *') }
      it { should have_content('End Date *') }
      it { should have_content('Reason') }

      # Cannot test form submits because of Angular
    end
  end

  describe 'edit' do
    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:time_off_request,
                         location_id: location.id,
                         user_id: user.id)
      visit edit_time_off_request_path(TimeOffRequest.last)
    end

    describe 'time off request' do
      let(:edited_reason) { 'edit content' }
      let(:submit) { 'Save Changes' }

      it { should have_selector('h1', text: 'Edit Time Off Request') }
      it { should have_title(full_title('Edit Time Off Request')) }
      it { should have_content('Start Date *') }
      it { should have_content('End Date *') }
      it { should have_content('All Day') }

      # Cannot test form submits because of Angular
    end
  end

  describe 'show' do

    before do
      login_as(admin, scope: :user)
      FactoryGirl.create(:time_off_request,
                         location_id: location.id,
                         user_id: user.id,
                         active: false)
      visit time_off_request_path(TimeOffRequest.last)
    end

    describe 'time_off_request' do
      it { should have_selector('h1', text: 'Time Off Request') }
      it { should have_title(full_title('Time Off Request')) }
      it { should have_link('', time_off_requests_path) }

      describe 'attributes' do
        it { should have_selector('th', text: 'Submitted By') }
        it { should have_selector('th', text: 'Location') }
        it { should have_selector('th', text: 'Date Submitted') }
        it { should have_selector('th', text: 'Start Date') }
        it { should have_selector('th', text: 'End Date') }
        it { should have_selector('th', text: 'Reason') }
        it { should have_selector('th', text: 'Status') }
        it { should have_selector('th', text: 'Processed By') }
        it { should have_selector('th', text: 'Processed On') }

        it do should have_selector('td',
                                   text: user.first_name) end
        it do should have_selector('td',
                                   text: user.last_name) end
      end
    end
  end
end
