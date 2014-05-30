require 'spec_helper'

describe PrivateLesson do

  before do
    @private_lesson = PrivateLesson.new(
      account_id:             1,
      parent_first_name:      'Lydia',
      parent_last_name:       'Pierce',
      phone_number:           '720-387-9691',
      email:                  'michael@affektive.com',
      contact_method:         'Call',
      instructor_gender:      'F',
      notes:                  'No Jake',
      lesson_objective:       'Get Better',
      meeting_time_agreement: 'Sat 8am',
      sunday_morning:         true,
      sunday_afternoon:       true,
      sunday_evening:         true,
      monday_morning:         true,
      monday_afternoon:       true,
      monday_evening:         true,
      tuesday_morning:        true,
      tuesday_afternoon:      true,
      tuesday_evening:        true,
      wednesday_morning:      true,
      wednesday_afternoon:    true,
      wednesday_evening:      true,
      thursday_morning:       true,
      thursday_afternoon:     true,
      thursday_evening:       true,
      friday_morning:         true,
      friday_afternoon:       true,
      friday_evening:         true,
      saturday_morning:       true,
      saturday_afternoon:     true,
      saturday_evening:       true,
      package_id:             1)
  end

  subject { @private_lesson }

  it { should respond_to(:account_id) }
  it { should respond_to(:parent_first_name) }
  it { should respond_to(:parent_last_name) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:email) }
  it { should respond_to(:contact_method) }
  it { should respond_to(:instructor_gender) }
  it { should respond_to(:notes) }
  it { should respond_to(:lesson_objective) }
  it { should respond_to(:meeting_time_agreement) }
  it { should respond_to(:sunday_morning) }
  it { should respond_to(:sunday_afternoon) }
  it { should respond_to(:sunday_evening) }
  it { should respond_to(:monday_morning) }
  it { should respond_to(:monday_afternoon) }
  it { should respond_to(:monday_evening) }
  it { should respond_to(:tuesday_morning) }
  it { should respond_to(:tuesday_afternoon) }
  it { should respond_to(:tuesday_evening) }
  it { should respond_to(:wednesday_morning) }
  it { should respond_to(:wednesday_afternoon) }
  it { should respond_to(:wednesday_evening) }
  it { should respond_to(:thursday_morning) }
  it { should respond_to(:thursday_afternoon) }
  it { should respond_to(:thursday_evening) }
  it { should respond_to(:friday_morning) }
  it { should respond_to(:friday_afternoon) }
  it { should respond_to(:friday_evening) }
  it { should respond_to(:saturday_morning) }
  it { should respond_to(:saturday_afternoon) }
  it { should respond_to(:saturday_evening) }
  it { should respond_to(:package_id) }

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

  describe 'when lesson package is not present' do
    before { @private_lesson.package = nil }
    it { should_not be_valid }
  end
end
