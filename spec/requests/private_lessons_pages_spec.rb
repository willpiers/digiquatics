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
  let!(:private_lesson) { FactoryGirl.create(:private_lesson, account_id: account.id) }

  before do
    login_as(user, scope: :user)
    FactoryGirl.create(:private_lesson,
                       account_id:          account.id,
                       parent_first_name:   'unassigned_lesson',
                       contact_method:      'Call',
                       number_lessons:      '5',
                       user_id:             nil,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       account_id:          account.id,
                       parent_first_name:   'my_lesson',
                       contact_method:      'Call',
                       number_lessons:      '5',
                       user_id:             user.id,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       account_id:          another_account.id,
                       parent_first_name:   'other_account_lesson',
                       contact_method:      'Text',
                       number_lessons:      '3',
                       user_id:             user.id - 1,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       parent_first_name:   'other_user_lesson',
                       contact_method:      'Text',
                       number_lessons:      '3',
                       user_id:             user.id - 1,
                       preferred_location:  location.id)
  end

  subject { page }

  describe 'Queue' do
    before { visit account_private_lessons_path(account_id: user.account_id) }

    describe 'should not list lessons from another account' do
      it { should_not have_content('other_account_lesson') }
    end

    describe 'should list a lesson not assigned to a user' do
      it { should have_content('unassigned_lesson') }
    end

    describe 'should not list a lesson assigned to a user' do
      it { should_not have_content('my_lesson') }
    end
  end

  describe 'My Lessons' do
    before { visit my_lessons_path }

    describe 'should not list lessons from another account' do
      it { should_not have_content('other_account_lesson') }
    end

    describe 'should list current users lessons' do
      it { should have_content('my_lesson') }
    end

    describe 'should not list other users lessons' do
      it { should_not have_content('other_user_lesson') }
    end
  end

  describe 'Manage as Admin' do
    before { visit admin_index_path }

    describe 'should list lessons from current users account' do
      it { should have_content('my_lesson') }
    end

    describe 'should not list lessons from another account' do
      it { should_not have_content('other_account_lesson') }
    end

    describe 'should list a lesson assigned to a user' do
      it { should have_content('my_lesson') }
    end

    describe 'should not list a lesson not assigned to a user' do
      it { should_not have_content('unassigned_lesson') }
    end
  end

  describe 'signup' do
    before do
      Warden.test_reset!
      login_as(user, scope: :user)
      FactoryGirl.create(:participant, private_lesson_id: private_lesson.id)
      visit edit_account_private_lesson_path(private_lesson)
    end

    let(:submit) { 'Submit' }

    describe 'with invalid information' do
      before { fill_in 'Parent First Name', with: ' ' }

      it 'should not create a private lesson' do
        expect { click_button submit }.not_to change(PrivateLesson, :count)
      end
    end

    describe 'with valid information' do
      before do
        FactoryGirl.create(:participant, private_lesson_id: private_lesson.id)
        # Parent information
        fill_in 'Parent First Name', with: 'Parent First'
        fill_in 'Parent Last Name',  with: 'Parent Last'
        fill_in 'Phone Number',      with: '1234'
        fill_in 'Email',             with: 'lesson@example.com'
        select  'Call',              from: 'Preferred Contact Method'

        # Student Information
        fill_in 'Student First Name', with: 'student first'
        fill_in 'Student Last Name',  with: 'student last'
        select 'M',           from: 'Gender'
        fill_in 'Age',        with: 14

        # Preferences
        select 'None',              from: 'Instructor Gender Preference'
        fill_in 'Notes',            with: 'I want Joey'
        fill_in 'Lesson Objectives', with: 'Starts and turns'

        # Lesson Request
        select 1, from: 'Number of Lessons'
      end

      it 'should create a private lesson' do
        expect { click_button submit }.to change(PrivateLesson, :count).by(1)
      end

      describe 'after saving the lesson' do
        before { click_button submit }
        let(:created_lesson) do
          PrivateLesson.find_by_email('lesson@example.com')
        end

        it 'should redirect to confirmation page' do
          # insert confirmation page
        end
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

      it { should have_content('Instructor Information') }
    end

    describe 'as non-admin' do
      before do
        Warden.test_reset!
        login_as(user, scope: :user)
        visit private_lesson_path(created_lesson)
      end

      it { should_not have_content('Instructor Information') }
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
          select  'Call',              from: 'Preferred Contact Method'

          # Student Information
          fill_in 'Student First Name', with: student_first_name
          fill_in 'Student Last Name',  with: 'student last'
          select 'M',           from: 'Gender'
          fill_in 'Age',        with: 14

          # Preferences
          select 'None',              from: 'Instructor Gender Preference'
          fill_in 'Notes',            with: 'I want Joey'
          fill_in 'Lesson Objectives', with: 'Starts and turns'

          # Lesson Request
          select 1, from: 'Number of Lessons'

          click_button 'Save Changes'
        end

        it { should have_title(full_title(student_first_name)) }
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
        it { should have_selector('h1', text: full_name) }
        it { should have_title(full_title(full_name)) }

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
