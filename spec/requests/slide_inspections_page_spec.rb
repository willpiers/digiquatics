require 'spec_helper'

describe 'Slide Inspection pages' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }

  let!(:admin) do
    FactoryGirl.create(:admin, account_id: account.id)
  end

  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id)
  end

  let!(:slide) { FactoryGirl.create(:slide, location_id: location.id) }

  let!(:slide_inspection) do
    FactoryGirl.create(:slide_inspection,
                       slide_id: slide.id,
                       user_id: user.id,
                       notes: 'all is good')
  end

  let!(:slide_inspection_with_error) do
    FactoryGirl.create(:slide_inspection,
                       slide_id: slide.id,
                       user_id: user.id,
                       notes: 'bad bolts')
  end

  subject { page }

  describe 'index' do
    before do
      login_as(admin, scope: :user)
      24.times do
        FactoryGirl.create(:slide_inspection_task,
                           slide_inspection_id: slide_inspection.id)
      end
      visit slide_inspections_path
    end

    it { should have_selector('h1', text: 'Slide Inspections') }
    it { should have_title(full_title('Slide Inspections')) }
    it { should have_link('New Slide Inspection', new_slide_inspection_path) }

    it { should have_selector('th', text: 'Slide') }
    it { should have_selector('th', text: 'Completed By') }
    it { should have_selector('th', text: 'Date') }
    it { should have_selector('th', text: 'All OK?') }
    it { should have_content('slide.name') }
    it { should have_content("inspection.created_at | date:'M/d/yy h:mm a'") }
    it { should have_content('user.first_name') }
    it { should have_content('user.last_name') }
  end

  describe 'new' do
    before do
      login_as(user, scope: :user)
      visit new_slide_inspection_path
    end

    describe 'slide inspection' do
      let(:submit) { 'Submit' }

      it { should have_content('New Slide Inspection') }
      it { should have_title('New Slide Inspection') }
      it { should have_content('Notes') }

      describe 'with valid information' do

        before do
          select slide.name, from: 'slide_inspection_slide_id'
          # check all are completed by default
        end

        it 'should create a slide inspection record' do
          expect { click_button submit }.to change(SlideInspection, :count).by(1)
        end

        it 'should also create a slide inspection task records' do
          expect { click_button submit }.to change(SlideInspectionTask, :count).by(24)
        end

        it 'should not create a help desk ticket' do
          expect { click_button submit }.to change(HelpDesk, :count).by(0)
        end
      end

      describe 'with an error' do
        before do
          select slide.name, from: 'slide_inspection_slide_id'
          uncheck 'slide_inspection_slide_inspection_tasks_attributes_0_completed'
        end

        it 'should create a slide inspection record' do
          expect { click_button submit }.to change(SlideInspection, :count).by(1)
        end

        it 'should also create a slide inspection task records' do
          expect { click_button submit }.to change(SlideInspectionTask, :count).by(24)
        end

        it 'should also create a help desk ticket' do
          expect { click_button submit }.to change(HelpDesk, :count).by(1)
        end
      end

      describe 'with an error should create HelpDesk ticket' do
        let(:entered_notes) { 'blah blah blah' }

        before do
          select slide.name, from: 'slide_inspection_slide_id'
          uncheck 'slide_inspection_slide_inspection_tasks_attributes_0_completed'
          fill_in 'Notes', with: entered_notes
          click_button submit
          visit help_desk_path(HelpDesk.last)
        end

        it { should have_content('Issue') }
        it { should have_content("#{slide.name} Slide Inspection Issue") }
        it { should have_content('Issues: Dry Slide Inspection') }
        it { should have_content("Employee Notes: #{entered_notes}") }
        it { should have_content("#{slide.location.name}") }
        it { should have_content("#{user.first_name}") }
        it { should have_content("#{user.last_name}") }
      end
    end
  end

  describe 'show' do
    before do
      login_as(user, scope: :user)
      24.times do
        FactoryGirl.create(:slide_inspection_task,
                           slide_inspection_id: slide_inspection.id)
      end
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
        it { should have_selector('th', text: 'Notes') }
        it { should have_selector('td', text: slide.name) }
        it do should have_selector('td',
                                   text: slide_inspection.user.first_name) end
        it do should have_selector('td',
                                   text: slide_inspection.user.last_name) end
        it do should have_selector('td',
                                   text: slide_inspection.notes) end
      end
    end
  end

  describe 'show inspection with an error' do
    let(:error) { 'Pool Depth Markers (Legible)' }

    before do
      login_as(user, scope: :user)
      23.times do
        FactoryGirl.create(:slide_inspection_task,
                           slide_inspection_id: slide_inspection_with_error.id)
      end
      FactoryGirl.create(:slide_inspection_task,
                         slide_inspection_id: slide_inspection_with_error.id,
                         task_name: 'Pool Depth Markers (Legible)',
                         completed: false)
      visit slide_inspection_path(slide_inspection_with_error)
    end

    describe 'attributes' do
      it { should have_selector('th', text: 'Errors') }
      it { should have_selector('td', text: 'No') }
      it { should have_content(error) }
    end
  end
end
