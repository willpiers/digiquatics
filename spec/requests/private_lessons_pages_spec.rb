require 'spec_helper'

describe 'Private Lessons' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:another_account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
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

  describe 'Manage as Admin' do
    before { visit admin_index_path }

    it { should have_content('Private Lessons Mangement') }
  end

  describe 'signup' do
    before do
      Warden.test_reset!
      login_as(user, scope: :user)
      visit new_account_private_lesson_path(account_id: user.account_id)
    end

    it { should have_title(full_title('Lesson Request')) }
    it { should have_selector('legend', text: 'Lesson Request') }
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
        select 'Call',               from: 'Preferred Contact Method'
        check 'Sunday Morning'
        check 'Sunday Afternoon'
        check 'Sunday Evening'
        check 'Monday Morning'
        check 'Monday Afternoon'
        check 'Monday Evening'
        check 'Tuesday Morning'
        check 'Tuesday Afternoon'
        check 'Tuesday Evening'
        check 'Wednesday Morning'
        check 'Wednesday Afternoon'
        check 'Wednesday Evening'
        check 'Thursday Morning'
        check 'Thursday Afternoon'
        check 'Thursday Evening'
        check 'Friday Morning'
        check 'Friday Afternoon'
        check 'Friday Evening'
        check 'Saturday Morning'
        check 'Saturday Afternoon'
        check 'Saturday Evening'
      end

      it 'should create a private lesson' do
        expect { click_button submit }.to change(PrivateLesson, :count).by(1)
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
      it { should have_selector('legend', text: 'Edit Private Lesson') }
      it { should have_title(full_title('Edit Private Lesson')) }

      describe 'with invalid information' do
        before do
          fill_in 'Parent First Name', with: ' '
          click_button 'Save Changes'
        end

        it { should have_content('can\'t be blank') }
      end

      describe 'with valid information' do

        let(:student_first_name) { 'Johnny' }

        before do
          # Parent information
          fill_in 'Parent First Name', with: 'Parent First'
          fill_in 'Parent Last Name',  with: 'Parent Last'
          fill_in 'Phone Number',      with: '1234'
          fill_in 'Email',             with: 'lesson@example.com'
          select 'Call',              from: 'Preferred Contact Method'

          # Student Information
          fill_in 'Student First Name', with: student_first_name
          fill_in 'Student Last Name',  with: 'student last'
          select 'M',           from: 'Gender'
          fill_in 'Age',        with: 14

          # Preferences
          fill_in 'Notes',            with: 'I want Joey'
          fill_in 'Lesson Objectives', with: 'Starts and turns'

          # Lesson Request
          select 1, from: 'Number of Lessons'

          click_button 'Save Changes'
        end

        it { should have_title('Lesson Request') }
        it { should have_selector('div.alert') }
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
          it { should have_selector('div.alert') }

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
end
