require 'spec_helper'

describe Account do
  before do
    @account = Account.new(name: 'City of Lakewood',
                           time_zone: 'Mountain Time (US & Canada)')
  end

  subject { @account }

  it { should respond_to :name }
  it { should respond_to :time_zone }

  it { should be_valid }

  describe 'when name is not present' do
    before { @account.name = nil }
    it { should_not be_valid }
  end
end
