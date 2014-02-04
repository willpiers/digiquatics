require 'spec_helper'

describe PrivateLesson do

  before do
    @private_lesson = PrivateLesson.new(
      parent_first_name:  'Lydia',
      parent_last_name:   'Pierce',
      phone_number:       '720-387-9691',
      email:              'michael@affektive.com',
      contact_method:     'Call',
      first_name:         'Michael',
      last_name:          'Pierce',
      sex:                'M',
      age:                '12',
      instructor_gender:  'F',
      notes:              'No Jake',
      lesson_objective:   'Get Better',
      number_lessons:     '5',
      day:                'Mon',
      time:               'AM')
  end

  subject { @private_lesson }

  it { should respond_to(:parent_first_name) }
  it { should respond_to(:parent_last_name) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:email) }
  it { should respond_to(:contact_method) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:sex) }
  it { should respond_to(:age) }
  it { should respond_to(:instructor_gender) }
  it { should respond_to(:notes) }
  it { should respond_to(:lesson_objective) }
  it { should respond_to(:number_lessons) }
  it { should respond_to(:day) }
  it { should respond_to(:time) }

  it { should be_valid }

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

  describe 'without first name is not present' do
    before { @private_lesson.first_name = nil }
    it { should_not be_valid }
  end

  describe 'without last name is not present' do
    before { @private_lesson.last_name = nil }
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

  describe 'when number of lessons is not present' do
    before { @private_lesson.number_lessons = nil }
    it { should_not be_valid }
  end
end
