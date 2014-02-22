require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

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

  before do
    login_as(user, scope: :user)
    FactoryGirl.create(:private_lesson,
                       account_id:          account.id,
                       first_name:          'unassigned_lesson',
                       contact_method:      'Call',
                       number_lessons:      '5',
                       user_id:             nil,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       account_id:          account.id,
                       first_name:          'my_lesson',
                       contact_method:      'Call',
                       number_lessons:      '5',
                       user_id:             user.id,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       account_id:          another_account.id,
                       first_name:          'other_account_lesson',
                       contact_method:      'Text',
                       number_lessons:      '3',
                       user_id:             user.id - 1,
                       preferred_location:  location.id)
    FactoryGirl.create(:private_lesson,
                       first_name:          'other_user_lesson',
                       contact_method:      'Text',
                       number_lessons:      '3',
                       user_id:             user.id - 1,
                       preferred_location:  location.id)
  end

  subject { page }

  describe 'Queue' do
    before { visit private_lessons_path }

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
      visit new_account_private_lesson_path
    end

    let(:submit) { }

    describe 'with invalid information' do
      it 'should not create a private lesson' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe 'with valid information' do
      before do
        select blank_account.name,       from: 'Account'
        fill_in 'First Name',            with: 'First'
        fill_in 'Last Name',             with: 'Last'
        fill_in 'Phone Number',          with: '1234'
        fill_in 'Email',                 with: 'user@example.com'
        fill_in 'Password',              with: 'foobar77'
        fill_in 'Password Confirmation', with: 'foobar77'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:created_user) { User.find_by_email('user@example.com') }

        it 'should be an admin' do
          created_user.admin.should eq true
        end

        it { should have_link('Sign out') }
        it { should have_selector('div.alert') }
      end
    end
  end
end
