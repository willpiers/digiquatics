require 'spec_helper'

describe ShiftReport do

  before do
    @shift_report = ShiftReport.new(
      content: 'sandlflasdfn',
      user_id:      1,
      location_id:  1,
      report_filed: true)
  end

  subject { @shift_report }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:location_id) }
  it { should respond_to(:report_filed) }
  it { should respond_to(:attachment_front) }
  it { should respond_to(:attachment_back) }

  it { should be_valid }

  describe 'when content is not present' do
    before { @shift_report.content = nil }
    it { should_not be_valid }
  end

  describe 'when user_id is not present' do
    before { @shift_report.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when location_id is not present' do
    before { @shift_report.location_id = nil }
    it { should_not be_valid }
  end

end
