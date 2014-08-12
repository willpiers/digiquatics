require 'spec_helper'

describe TimeOffRequest do

  before do
    @time_off_request = TimeOffRequest.new(
      user_id:     1,
      starts_at: Time.now,
      ends_at:   Time.now + 5.hours,
      reason: 'I want time off',
      approved:  true,
      active: false,
      approved_by_user_id: 2,
      location_id: 1,
      processed_by_last_name: 'Last',
      processed_by_last_name: 'First',
      approved_at: Time.now + 10.hours)
  end

  subject { @time_off_request }

  it { should respond_to(:user_id) }
  it { should respond_to(:starts_at) }
  it { should respond_to(:ends_at) }
  it { should respond_to(:reason) }
  it { should respond_to(:approved) }
  it { should respond_to(:active) }
  it { should respond_to(:approved_by_user_id) }
  it { should respond_to(:location_id) }
  it { should respond_to(:processed_by_last_name) }
  it { should respond_to(:processed_by_last_name) }
  it { should respond_to(:approved_at) }

  it { should be_valid }

  describe 'when user_id is not present' do
    before { @time_off_request.user_id = nil }
    it { should_not be_valid }
  end

  describe 'when starts_at is not present' do
    before { @time_off_request.starts_at = nil }
    it { should_not be_valid }
  end

  describe 'when ends_at is not present' do
    before { @time_off_request.ends_at = nil }
    it { should_not be_valid }
  end
end
