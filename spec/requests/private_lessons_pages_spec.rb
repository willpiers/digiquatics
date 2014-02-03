require 'spec_helper'

describe 'Private Lessons' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) do
    FactoryGirl.create(:user,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  before do
    sign_in user
    FactoryGirl.create(:private_lesson,
                       first_name: 'my_lesson',
                       contact_method: 'Call',
                       number_lessons: '5',
                       user_id: user.id,
                       preferred_location: location.id)
    FactoryGirl.create(:private_lesson,
                       first_name: 'other_user_lesson',
                       contact_method: 'Text',
                       number_lessons: '3',
                       user_id: user.id - 1,
                       preferred_location: location.id)
  end

  subject { page }

  describe 'Queue' do
    before { visit private_lessons_path }

    describe 'should list current users lessons' do
      it { should have_content('my_lesson') }
    end

    describe 'should also list other users lessons' do
      it { should have_content('other_user_lesson') }
    end
  end

  describe 'My Lessons' do
    before { visit my_lessons_path }

    describe 'should list current users lessons' do
      it { should have_content('my_lesson') }
    end

    describe 'should not list other users lessons' do
      it { should_not have_content('other_user_lesson') }
    end
  end
end
