require 'spec_helper'

describe Availability do

  before do
    @availability = Availability.new(user_id: 1)
  end

  subject { @availability }

  it { should respond_to(:user_id) }
  it { should be_valid }

  describe 'when user_id is not present' do
    before { @availability.user_id = nil }
    it { should_not be_valid }
  end
end
