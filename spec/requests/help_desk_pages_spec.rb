require 'spec_helper'

describe 'Help Desk pages' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }

  let!(:admin) do
    FactoryGirl.create(:admin, account_id: account.id)
  end

  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id)
  end

  subject { page }

  describe 'index' do
    before do
      login_as(admin, scope: :user)
      visit help_desks_path
    end

    it { should have_selector('h1', text: 'Open Issues') }
    it { should have_title(full_title('Open Issues')) }
    it { should have_link('New Issue', new_help_desk_path) }
    it { should have_link('View Closed', closed_index_path) }

    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Date') }
    it { should have_selector('th', text: 'Problem') }
    it { should have_selector('th', text: 'Urgency') }
    it { should have_selector('th', text: 'Submitted By') }
    it { should have_content('location.name') }
    it { should have_content('item.name') }
    it { should have_content('item.urgency') }
    it { should have_content("item.created_at | date:'M/d/yy h:mm a'") }
    it { should have_content('user.first_name') }
    it { should have_content('user.last_name') }
  end

  describe 'closed index' do
    before do
      login_as(admin, scope: :user)
      visit closed_index_path
    end

    it { should have_selector('h1', text: 'Closed Issues') }
    it { should have_title(full_title('Closed Issues')) }
    it { should_not have_link('New Issue', new_help_desk_path) }
    it { should have_link('View Open', help_desks_path) }
    it { should_not have_link('View Closed', closed_index_path) }

    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Date Opened') }
    it { should have_selector('th', text: 'Date Closed') }
    it { should have_selector('th', text: 'Problem') }
    it { should have_selector('th', text: 'Urgency') }
    it { should have_selector('th', text: 'Submitted By') }

    it { should have_content('location.name') }
    it { should have_content('item.name') }
    it { should have_content('item.urgency') }
    it { should have_content("item.created_at | date:'M/d/yy h:mm a'") }
    it { should have_content("item.closed_date_time | date:'M/d/yy h:mm a'") }
    it { should have_content('user.first_name') }
    it { should have_content('user.last_name') }
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_help_desk_path
    end

    describe 'slide inspection' do
      let(:problem) { 'New Problem' }
      let(:description) { 'New Description' }
      let(:submit) { 'Submit' }

      it { should have_selector('h1', text: 'New Issue') }
      it { should have_title(full_title('New Issue')) }
      it { should have_content('Attachment') }

      describe 'with valid information' do
        before do
          fill_in 'Problem', with: problem
          fill_in 'Description', with: description
          select 'Low', from: 'help_desk_urgency'
        end

        it 'should create a help desk record' do
          expect { click_button submit }.to change(HelpDesk, :count).by(1)
        end

        describe 'redirect to index' do
          before { click_button submit }
          it { current_path.should eq help_desks_path }
        end
      end

      describe 'with invalid information' do
        before do
          fill_in 'Description', with: description
          select 'Low', from: 'help_desk_urgency'
        end

        it 'should not create a help desk record' do
          expect { click_button submit }.to_not change(HelpDesk, :count).by(1)
        end
      end
    end
  end

  describe 'show' do

    before do
      login_as(admin, scope: :user)
      FactoryGirl.create(:help_desk,
                         location_id: location.id,
                         user_id: user.id)
      visit help_desk_path(HelpDesk.last)
    end

    describe 'help desk' do
      it { should have_selector('h1', text: "Issue # #{HelpDesk.last.id}") }
      it { should have_title(full_title('Help Desk Issue')) }

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
