require 'spec_helper'

describe PrivateLesson do

  before do
    @private_lesson = PrivateLesson.new(
      first_name:         'Michael',
      email:              'michael@affektive.com',
      last_name:          'Pierce',
      phone_number:       '720-387-9691',
      parent_first_name:  'Trent',
      parent_last_name:   'Allen',
      sex:                'M',
      age:                '12',
      instructor_gender:  'F',
      notes:              'No Jake',
      day:                'Mon',
      time:               'AM',
      ability_level:      '6')
  end

  subject { @private_lesson }

  it { should respond_to(:first_name) }
  it { should respond_to(:email) }
  it { should respond_to(:last_name) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:parent_first_name) }
  it { should respond_to(:parent_last_name) }
  it { should respond_to(:sex) }
  it { should respond_to(:age) }
  it { should respond_to(:instructor_gender) }
  it { should respond_to(:notes) }
  it { should respond_to(:day) }
  it { should respond_to(:time) }
  it { should respond_to(:ability_level) }

  it { should be_valid }

  describe 'without first name is not present' do
    before { @private_lesson.first_name = nil }
    it { should_not be_valid }
  end

  describe 'without email is not present' do
    before { @private_lesson.email = nil }
    it { should_not be_valid }
  end

  describe 'without last name is not present' do
    before { @private_lesson.last_name = nil }
    it { should_not be_valid }
  end

  describe 'when phone number is not present' do
    before { @private_lesson.phone_number = ' ' }
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

  describe 'when sex is not present' do
    before { @private_lesson.sex = ' ' }
    it { should_not be_valid }
  end

  describe 'when age is not present' do
    before { @private_lesson.age = ' ' }
    it { should_not be_valid }
  end

  describe 'when instructor gender is not present' do
    before { @private_lesson.instructor_gender = ' ' }
    it { should_not be_valid }
  end

  describe 'when notes is not present' do
    before { @private_lesson.notes = ' ' }
    it { should_not be_valid }
  end

    describe 'when day is not present' do
    before { @private_lesson.day = ' ' }
    it { should_not be_valid }
  end

  describe 'when time is not present' do
    before { @private_lesson.time = ' ' }
    it { should_not be_valid }
  end

  describe 'when ability level is not present' do
    before { @private_lesson.ability_level = ' ' }
    it { should_not be_valid }
  end

end
