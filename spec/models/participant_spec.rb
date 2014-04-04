require 'spec_helper'

describe Participant do

  before do
    @participant = Participant.new(
      private_lesson_id:  1,
      first_name:         'Lydia',
      last_name:          'Pierce',
      sex:                'M',
      age:                '12',
      instructor_gender:  'F',
      notes:              'No Jake',
      lesson_objective:   'Get Better')
  end

  subject { @participant }

  it { should respond_to(:private_lesson_id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:sex) }
  it { should respond_to(:age) }
  it { should respond_to(:instructor_gender) }
  it { should respond_to(:notes) }
  it { should respond_to(:lesson_objective) }

  it { should be_valid }

  describe 'when private_lesson_id is not present' do
    before { @participant.private_lesson_id = ' ' }
    it { should_not be_valid }
  end

  describe 'when first name is not present' do
    before { @participant.first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when sex is not present' do
    before { @participant.sex = ' ' }
    it { should_not be_valid }
  end

  describe 'when age is not present' do
    before { @participant.age = ' ' }
    it { should_not be_valid }
  end
end
