require 'spec_helper'

describe Shift do

  before do
    @shift = Shift.new(
      user_id:     1,
      position_id: 1,
      location_id: 1,
      start_time:  Time.zone.now,
      end_time:    Time.zone.now + 5.hours)
  end

  subject { @shift }

  it { should respond_to(:user_id) }
  it { should respond_to(:position_id) }
  it { should respond_to(:location_id) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @shift.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when position_id is not present' do
    before { @shift.position_id = nil }
    it { should_not be_valid }
  end

  describe 'when location_id is not present' do
    before { @shift.location_id = nil }
    it { should_not be_valid }
  end

  describe 'when start_time is not present' do
    before { @shift.start_time = nil }
    it { should_not be_valid }
  end

  describe 'when end_time is not present' do
    before { @shift.end_time = nil }
    it { should_not be_valid }
  end
end
