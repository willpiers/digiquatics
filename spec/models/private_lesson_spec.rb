require 'spec_helper'

describe PrivateLesson do

  before do
    @private_lesson = PrivateLesson.new(
      account_id:         1,
      parent_first_name:  'Lydia',
      parent_last_name:   'Pierce',
      phone_number:       '720-387-9691',
      email:              'michael@affektive.com',
      contact_method:     'Call',
      number_lessons:     '5',
      day:                'Mon',
      time:               'AM',
      instructor_gender:  'F',
      notes:              'No Jake',
      lesson_objective:   'Get Better')
  end

  subject { @private_lesson }

  it { should respond_to(:account_id) }
  it { should respond_to(:parent_first_name) }
  it { should respond_to(:parent_last_name) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:email) }
  it { should respond_to(:contact_method) }
  it { should respond_to(:number_lessons) }
  it { should respond_to(:day) }
  it { should respond_to(:time) }
  it { should respond_to(:instructor_gender) }
  it { should respond_to(:notes) }
  it { should respond_to(:lesson_objective) }

  it { should be_valid }

  describe 'when account_id is not present' do
    before { @private_lesson.account_id = ' ' }
    it { should_not be_valid }
  end

  describe 'when parent first name is not present' do
    before { @private_lesson.parent_first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when parent last name is not present' do
    before { @private_lesson.parent_last_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when phone number is not present' do
    before { @private_lesson.phone_number = ' ' }
    it { should_not be_valid }
  end

  describe 'without email is not present' do
    before { @private_lesson.email = nil }
    it { should_not be_valid }
  end

  describe 'when contact methid is not present' do
    before { @private_lesson.contact_method = nil }
    it { should_not be_valid }
  end

  describe 'when number of lessons is not present' do
    before { @private_lesson.number_lessons = nil }
    it { should_not be_valid }
  end
end
