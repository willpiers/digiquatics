require 'spec_helper'

describe 'Shift Report pages' do
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
      visit shift_reports_path
    end

    it { should have_selector('h1', text: 'Shift Reports') }
    it { should have_title(full_title('Shift Reports')) }
    it { should have_link('New Report', new_shift_report_path) }

    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Date') }
    it { should have_selector('th', text: 'Last Name') }
    it { should have_selector('th', text: 'First Name') }
    it { should have_selector('th', text: 'Report Filed') }
    it { should have_content('report.location.name') }
    it { should have_content("report.created_at | date:'M/d/yy h:mm a'") }
    it { should have_content('report.user.last_name') }
    it { should have_content('report.user.first_name') }
    it { should have_content('report.report_filed | booleanToWords') }
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_shift_report_path
    end

    describe 'shift report' do
      let(:content) { 'Example shift report content' }
      let(:submit) { 'Submit' }

      it { should have_selector('h1', text: 'New Shift Report') }
      it { should have_title(full_title('New Shift Report')) }
      it { should have_content('Incident Report Filed') }
      it { should have_content('Attachment #1') }
      it { should have_content('Attachment #2') }
      it { should have_content('Date') }

      describe 'with valid information' do
        before do
          fill_in 'Content', with: content
          check 'Incident / Accident Report Filed'
        end

        it 'should create a shift report' do
          expect { click_button submit }.to change(ShiftReport, :count).by(1)
        end

        describe 'redirect to index' do
          before { click_button submit }
          it { current_path.should eq shift_reports_path }
          it { should have_content('Shift Report successfully submitted.')}
        end
      end

      describe 'with invalid information' do
        before do
          check 'Incident Report Filed'
        end

        it 'should not create a help desk record' do
          expect { click_button submit }.to_not change(ShiftReport, :count).by(1)
        end
      end
    end
  end

  describe 'show' do

    before do
      login_as(admin, scope: :user)
      FactoryGirl.create(:shift_report,
                         location_id: location.id,
                         user_id: user.id)
      visit shift_report_path(ShiftReport.last)
    end

    describe 'help desk' do
      it { should have_selector('h1', text: "Issue # #{HelpDesk.last.id}") }
      it { should have_title(full_title('Help Desk Issue')) }
      it { should have_link('Back', shift_reports_path) }

      describe 'attributes' do
        it { should have_selector('th', text: 'Problem') }
        it { should have_selector('th', text: 'Description') }
        it { should have_selector('th', text: 'Original Picture') }
        it { should have_selector('th', text: 'Urgency') }
        it { should have_selector('th', text: 'Location') }
        it { should have_selector('th', text: 'Submitted By') }
        it { should have_selector('th', text: 'Date Submitted') }
        it { should have_selector('th', text: 'Issue Status') }
        it { should have_selector('th', text: 'Issue Notes') }
        it { should have_selector('td', text: location.name) }
        it do should have_selector('td',
                                   text: user.first_name) end
        it do should have_selector('td',
                                   text: user.last_name) end
        it do should have_selector('td',
                                   text: 'Add notes below') end
      end
    end
  end
end
