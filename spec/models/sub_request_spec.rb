require 'spec_helper'

describe SubRequest do

  before do
    @sub_request = SubRequest.new(
      shift_id:     1,
      approved:  true,
      active: false,
      processed_by_user_id: 2,
      processed_by_last_name: 'Last',
      processed_by_first_name: 'First',
      processed_on: Time.now + 10.hours)
  end

  subject { @sub_request }

  it { should respond_to(:shift_id) }
  it { should respond_to(:approved) }
  it { should respond_to(:active) }
  it { should respond_to(:processed_by_user_id) }
  it { should respond_to(:processed_by_last_name) }
  it { should respond_to(:processed_by_first_name) }
  it { should respond_to(:processed_on) }

  it { should be_valid }

  describe 'when shift_id is not present' do
    before { @sub_request.shift_id = nil }
    it { should_not be_valid }
  end
end
