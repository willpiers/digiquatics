require 'spec_helper'

describe Package do
  before do @package = Package.new(account_id: 1,
                                   name: '3 lessons ($50.00)') end

  subject { @package }

  it { should respond_to :account_id }
  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @package.name = nil }
    it { should_not be_valid }
  end

  describe 'when account_id is not present' do
    before { @package.account_id = nil }
    it { should_not be_valid }
  end
end
