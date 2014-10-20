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

    it { should have_selector('th', text: 'Start Date') }
    it { should have_selector('th', text: 'End Date') }
    it { should have_selector('th', text: 'Reason') }
    it { should have_selector('th', text: 'Status') }
    it { should have_selector('th', text: 'Date Submitted') }
    it { should have_selector('th', text: 'Processed By') }
    it { should have_selector('th', text: 'Processed On') }
  end
end
