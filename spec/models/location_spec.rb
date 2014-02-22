require 'spec_helper'

describe Location do

  before do
    @location = Location.new(account_id: 1,
                             name: 'Green Mtn')
  end

  subject { @location }

  it { should respond_to :account_id }
  it { should respond_to :name }

  it { should be_valid }

  describe 'when account_id is not present' do
    before { @location.account_id = nil }
    it { should_not be_valid }
  end

  describe 'when name is not present' do
    before { @location.name = nil }
    it { should_not be_valid }
  end
end
