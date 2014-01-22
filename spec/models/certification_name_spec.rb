require 'spec_helper'

describe CertificationName do

  before { @certfication_name = CertificationName.new(account_id: '1', name: 'CPR/AED') }
  subject { @certfication_name }

  it { should respond_to(:name) }
  it { should respond_to(:account_id) }

  it { should be_valid }

  describe 'when account_id is not present' do
    before { @certfication_name.account_id = nil }
    it { should_not be_valid }
  end

  describe 'when certification name is not present' do
    before { @certfication_name.name = ' ' }
    it { should_not be_valid }
  end
end
