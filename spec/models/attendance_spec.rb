require 'spec_helper'

describe AttendanceRecord do

  before do
    @attendance = AttendanceRecord.new(name: 'Slot1')
  end

  subject { @attendance }

  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @attendance.name = nil }
    it { should_not be_valid }
  end
end
