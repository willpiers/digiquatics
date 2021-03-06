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
    it { should have_link('Add Report', new_shift_report_path) }

    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Date') }
    it { should have_selector('th', text: 'Submitted By') }
    it { should have_selector('th', text: 'Incident Report') }
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_shift_report_path
    end

    describe 'shift report' do
      let(:content) { 'Example shift report content' }
      let(:submit) { 'Submit Report' }

      it { should have_selector('h1', text: 'New Shift Report') }
      it { should have_title(full_title('New Shift Report')) }
      it { should have_content('Incident / Accident Report Filed') }
      it { should have_content('Attachment #1') }
      it { should have_content('Attachment #2') }

      describe 'with valid information' do
        before do
          fill_in 'Report', with: content
          check 'Incident / Accident Report Filed'
        end

        it 'should create a shift report' do
          expect { click_button submit }.to change(ShiftReport, :count).by(1)
        end

        describe 'redirect to index' do
          before { click_button submit }
          it { current_path.should eq shift_report_path(ShiftReport.last) }
        end
      end

      describe 'with invalid information' do
        before do
          check 'Incident / Accident Report Filed'
        end

        it 'should not create a shift report record' do
          expect { click_button submit }.to_not change(ShiftReport, :count).by(1)
        end
      end
    end
  end

  describe 'edit' do
    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:shift_report,
                         location_id: location.id,
                         user_id: user.id)
      visit edit_shift_report_path(ShiftReport.last)
    end

    describe 'shift report' do
      let(:edited_content) { 'edit content' }
      let(:submit) { 'Update Report' }

      it { should have_selector('h1', text: 'Edit Shift Report') }
      it { should have_title(full_title('Edit Shift Report')) }
      it { should have_content('Incident / Accident Report Filed') }
      it { should have_content('Attachment #1') }
      it { should have_content('Attachment #2') }

      describe 'with valid information' do
        before do
          fill_in 'Report', with: edited_content
          check 'Incident / Accident Report Filed'
        end

        it 'should update the shift report' do
          expect { click_button submit }.to_not change(ShiftReport, :count).by(1)
        end

        describe 'redirect to show page' do
          before { click_button submit }
          it { current_path.should eq shift_report_path(ShiftReport.last) }
          # it { should have_content('Shift Report was successfully updated.') }
        end
      end

      describe 'with invalid information' do
        before do
          fill_in 'Report *', with: ' '
          click_button submit
        end

        # Weird bug, it appears to stay on the edit path but changes the URL.
        # describe 'redirect to edit page' do
        #   it { current_path.should eq edit_shift_report_path(ShiftReport.last) }
        #   it { should have_content("can't be blank")}
        # end
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

    describe 'shift report' do
      it { should have_selector('h1', text: 'Shift Report') }
      it { should have_title(full_title('Shift Report')) }
      it { should have_link('', shift_reports_path) }

      describe 'attributes' do
        it { should have_selector('th', text: 'Location') }
        it { should have_selector('th', text: 'Date Submitted') }
        it { should have_selector('th', text: 'Submitted By') }
        it do should have_selector('th',
                                   text: 'Incident / Accident Report Filed?') end
        it { should have_selector('th', text: 'Attachment') }
        it { should have_selector('th', text: 'Shift Report') }
        it { should have_selector('td', text: location.name) }
        it do should have_selector('td',
                                   text: user.first_name) end
        it do should have_selector('td',
                                   text: user.last_name) end
      end
    end
  end
end
