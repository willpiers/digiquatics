require 'spec_helper'

describe ShiftReport do

  before do
    @shift_report = ShiftReport.new(
      post_title:   'Day 1',
      time_stamp:   '2010-10-10 16:19:00 UTC',
      post_content: 'sandlflasdfn',
      user_id:      1,
      location_id:  1,
      report_filed: true)
  end

  subject { @shift_report }

  it { should respond_to(:post_title) }
  it { should respond_to(:time_stamp) }
  it { should respond_to(:post_content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:location_id) }
  it { should respond_to(:report_filed) }
  it { should respond_to(:attachment_front) }
  it { should respond_to(:attachment_back) }

  it { should be_valid }

  describe 'when time_stamp is not present' do
    before { @shift_report.time_stamp = nil }
    it { should_not be_valid }
  end

  describe 'when post_content is not present' do
    before { @shift_report.post_content = nil }
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
