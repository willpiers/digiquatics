require 'spec_helper'

describe Position do

  before { @position = Position.new(account_id: 1, name: 'LG') }

  subject { @position }

  it { should respond_to :account_id }
  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @position.name = nil }
    it { should_not be_valid }
  end
end
