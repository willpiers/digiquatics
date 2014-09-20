require 'spec_helper'

describe 'Private Lessons' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:another_account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:skill_level) do FactoryGirl.create(:skill_level,
                                          account_id: account.id) end
  let(:package) do FactoryGirl.create(:package,
                                      account_id: account.id) end
  let(:user) do
    FactoryGirl.create(:user,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  let!(:admin) do
    FactoryGirl.create(:admin,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  let!(:unassigned_lesson) do
    FactoryGirl.create(:private_lesson,
                       account_id: account.id,
                       user_id: nil,
                       preferred_location: location.id)
  end

  let!(:private_lesson) do
    FactoryGirl.create(:private_lesson,
                       account_id: account.id,
                       user_id: user.id,
                       preferred_location: location.id)
  end

  let!(:other_account_lesson) do
    FactoryGirl.create(:private_lesson,
                       account_id: another_account.id,
                       preferred_location: location.id)
  end

  let!(:other_user_lesson) do
    FactoryGirl.create(:private_lesson,
                       account_id: account.id,
                       user_id: user.id - 1,
                       preferred_location: location.id)
  end

  before do
    login_as(user, scope: :user)
    FactoryGirl.create(:skill_level,
                       account_id: account.id)
    FactoryGirl.create(:package,
                       account_id: account.id)
    FactoryGirl.create(:participant,
                       private_lesson_id:   unassigned_lesson.id,
                       first_name:          'unassigned_lesson')
    FactoryGirl.create(:participant,
                       private_lesson_id:   private_lesson.id,
                       first_name:          'my_lesson')
    FactoryGirl.create(:participant,
                       private_lesson_id:   other_account_lesson.id,
                       first_name:          'other_account_lesson')
    FactoryGirl.create(:participant,
                       private_lesson_id:   private_lesson.id,
                       first_name:          'other_user_lesson')
  end

  subject { page }

  describe 'Queue' do
    before { visit account_private_lessons_path(account_id: user.account_id) }

    it { should have_content('Private Lessons Queue') }
  end

  describe 'My Lessons' do
    before { visit my_lessons_path }

    it { should have_content('My Lessons') }
  end

  describe 'Manage as Admin Open' do
    before { visit admin_index_path }

    it { should have_title(full_title('Open Private Lessons')) }
    it { should have_content('Admin Private Lessons') }
    it { should have_selector('th', text: 'Instructor') }
    it { should have_selector('th', text: 'Instructor Phone') }
    it { should have_selector('th', text: 'Parent') }
    it { should have_selector('th', text: 'Parent Phone') }
    it { should have_selector('th', text: 'Student') }
    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Submitted') }
    it { should have_selector('th', text: 'Claimed') }
  end

  describe 'Manage as Admin Completed' do
    before { visit completed_admin_index_path }

    it { should have_title(full_title('Completed Private Lessons')) }
    it { should have_content('Completed Private Lessons Mangement') }
    it { should have_selector('th', text: 'Instructor') }
    it { should have_selector('th', text: 'Instructor Phone') }
    it { should have_selector('th', text: 'Parent') }
    it { should have_selector('th', text: 'Parent Phone') }
    it { should have_selector('th', text: 'Student') }
    it { should have_selector('th', text: 'Location') }
    it { should have_selector('th', text: 'Submitted') }
    it { should have_selector('th', text: 'Claimed') }
    it { should have_selector('th', text: 'Completed') }
  end

  describe 'signup while not signed in' do
    before do
      Warden.test_reset!
      visit new_account_private_lesson_path(account_id: account.id)
    end

    it { should have_title(full_title('Lesson Request')) }
    it { should have_selector('h4', text: 'Parent Information') }
    it { should have_selector('h4', text: 'Student Information') }
    it { should have_selector('h4', text: 'Lesson Request') }

    let(:submit) { 'Submit' }

    describe 'with valid information' do
      before do
        fill_in 'Parent First Name', with: 'Josh'
        fill_in 'Parent Last Name',  with: 'Josh'
        fill_in 'Phone Number',      with: '303-921-8628'
        fill_in 'Parent First Name', with: 'Josh'
        fill_in 'Email',             with: 'Josh.m.duffy@gmail.com'
        select 'Primary (Call)',               from: 'Preferred Contact Method'
        fill_in 'Student First Name', with: 'CJ'
        select 'M', from: 'Gender *'
        fill_in 'Age *', with: '12'
        check 'private_lesson_sunday_morning'
        check 'private_lesson_sunday_afternoon'
        check 'private_lesson_sunday_evening'
        check 'private_lesson_monday_morning'
        check 'private_lesson_monday_afternoon'
        check 'private_lesson_monday_evening'
        check 'private_lesson_tuesday_morning'
        check 'private_lesson_tuesday_afternoon'
        check 'private_lesson_tuesday_evening'
        check 'private_lesson_wednesday_morning'
        check 'private_lesson_wednesday_afternoon'
        check 'private_lesson_wednesday_evening'
        check 'private_lesson_thursday_morning'
        check 'private_lesson_thursday_afternoon'
        check 'private_lesson_thursday_evening'
        check 'private_lesson_friday_morning'
        check 'private_lesson_friday_afternoon'
        check 'private_lesson_friday_evening'
        check 'private_lesson_saturday_morning'
        check 'private_lesson_saturday_afternoon'
        check 'private_lesson_saturday_evening'
        select package.name, from: 'Lesson Package *'
      end

      it 'should create a private lesson' do
        # expect { click_button submit }.to change(PrivateLesson, :count).by(1)
      end
    end

    describe 'with invalid information' do
      before { fill_in 'Parent First Name', with: ' ' }

      it 'should not create a private lesson' do
        expect { click_button submit }.not_to change(PrivateLesson, :count)
      end
    end
  end

  describe 'lesson request while signed in' do
    before do
      Warden.test_reset!
      login_as(user, scope: :user)
      visit new_account_private_lesson_path(account_id: user.account_id)
    end

    it { should have_title(full_title('Lesson Request')) }
    it { should have_selector('h4', text: 'Parent Information') }
    it { should have_selector('h4', text: 'Student Information') }
    it { should have_selector('h4', text: 'Lesson Request') }

    let(:submit) { 'Submit Lesson' }

    describe 'with valid information' do
      before do
        fill_in 'Parent First Name', with: 'Josh'
        fill_in 'Parent Last Name',  with: 'Josh'
        fill_in 'Phone Number',      with: '303-921-8628'
        fill_in 'Parent First Name', with: 'Josh'
        fill_in 'Email',             with: 'Josh.m.duffy@gmail.com'
        select 'Primary (Call)',               from: 'Preferred Contact Method'
        fill_in 'Student First Name', with: 'CJ'
        select 'M', from: 'Gender *'
        fill_in 'Age *', with: '12'
        check 'private_lesson_sunday_morning'
        check 'private_lesson_sunday_afternoon'
        check 'private_lesson_sunday_evening'
        check 'private_lesson_monday_morning'
        check 'private_lesson_monday_afternoon'
        check 'private_lesson_monday_evening'
        check 'private_lesson_tuesday_morning'
        check 'private_lesson_tuesday_afternoon'
        check 'private_lesson_tuesday_evening'
        check 'private_lesson_wednesday_morning'
        check 'private_lesson_wednesday_afternoon'
        check 'private_lesson_wednesday_evening'
        check 'private_lesson_thursday_morning'
        check 'private_lesson_thursday_afternoon'
        check 'private_lesson_thursday_evening'
        check 'private_lesson_friday_morning'
        check 'private_lesson_friday_afternoon'
        check 'private_lesson_friday_evening'
        check 'private_lesson_saturday_morning'
        check 'private_lesson_saturday_afternoon'
        check 'private_lesson_saturday_evening'
        select package.name, from: 'Lesson Package *'
      end

      it 'should create a private lesson' do
        # expect { click_button submit }.to change(PrivateLesson, :count).by(1)
      end
    end

    describe 'with invalid information' do
      before { fill_in 'Parent First Name', with: ' ' }

      it 'should not create a private lesson' do
        expect { click_button submit }.not_to change(PrivateLesson, :count)
      end
    end
  end

  describe 'show' do
    let(:created_lesson) do
      PrivateLesson.first
    end

    describe 'as admin' do
      before do
        Warden.test_reset!
        login_as(admin, scope: :user)
        visit private_lesson_path(created_lesson)
      end

      it { should have_title(full_title('Lesson Request')) }
      it { should have_selector('h1', text: 'Lesson Request') }
      it { should have_content('Instructor Information') }
      it { should have_content('Skill Level') }
      it { should have_content('Lesson Package') }
      it { should have_selector('h4', text: 'Availability') }
    end

    describe 'as non-admin' do
      before do
        Warden.test_reset!
        login_as(user, scope: :user)
        visit private_lesson_path(created_lesson)
      end

      it { should_not have_content('Instructor Information') }
      it { should have_selector('h4', text: 'Availability') }
      it { should have_content('Morning') }
      it { should have_content('Afternoon') }
      it { should have_content('Evening') }
      it { should have_content('Sunday') }
      it { should have_content('Monday') }
      it { should have_content('Tuesday') }
      it { should have_content('Wednesday') }
      it { should have_content('Thursday') }
      it { should have_content('Friday') }
      it { should have_content('Saturday') }
    end
  end

  describe 'edit' do
    let(:created_lesson) do
      PrivateLesson.first
    end

    before do
      Warden.test_reset!
      login_as(user, scope: :user)
      visit edit_private_lesson_path(created_lesson)
    end

    describe 'page' do
      it { should have_title(full_title('Edit Private Lesson')) }

      describe 'with invalid information' do
        before do
          fill_in 'Parent First Name', with: ' '
          click_button 'Update Lesson'
        end

        it { should have_content('can\'t be blank') }
      end

      describe 'with valid information' do

        let(:student_first_name) { 'Johnny' }

        before do
          # Meeting Arrangement
          fill_in 'private_lesson_meeting_time_agreement', with: 'Sat 8am'

          # Parent information
          fill_in 'Parent First Name', with: 'Parent First'
          fill_in 'Parent Last Name',  with: 'Parent Last'
          fill_in 'Phone Number',      with: '1234'
          fill_in 'Email',             with: 'lesson@example.com'
          select 'Primary (Call)',              from: 'Preferred Contact Method'

          # Student Information
          fill_in 'Student First Name', with: student_first_name
          fill_in 'Student Last Name',  with: 'student last'
          select 'M',           from: 'Gender'
          fill_in 'Age',        with: 14

          # Preferences
          fill_in 'Notes',            with: 'I want Joey'
          fill_in 'Lesson Objectives', with: 'Starts and turns'

          # Lesson Request
          select package.name, from: 'Lesson Package *'

          click_button 'Update Lesson'
        end

        it { should have_title('Lesson Request') }
        specify { current_path.should eq private_lesson_path(created_lesson) }
      end
    end

    describe 'claim' do
      let(:lesson) do
        PrivateLesson.first
      end

      let(:full_name) do
        "#{lesson.first_name} #{lesson.last_name}"
      end

      before do
        Warden.test_reset!
        login_as(user, scope: :user)
        visit private_lesson_path(lesson)
      end

      describe 'page' do
        it { should have_selector('h1', text: 'Lesson Request') }
        it { should have_title(full_title('Lesson Request')) }

        describe 'action' do
          before { click_button 'Claim Lesson' }

          specify { current_path.should eq private_lesson_path(lesson) }

          describe 'from admin view' do
            before do
              Warden.test_reset!
              login_as(admin, scope: :user)
              visit private_lesson_path(lesson)
            end

            describe 'should display Instructor info' do
              it { should have_content(user.first_name) }
            end
          end
        end
      end
    end
  end

  describe 'stats' do
    before do
      login_as(admin, scope: :user)
      visit private_lesson_stats_path
    end

    it { should have_title(full_title('Private Lesson Statistics')) }
    it { should have_selector('h1', text: 'Private Lesson Statistics') }
  end
end
