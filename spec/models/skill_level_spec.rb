require 'spec_helper'

describe SkillLevel do
  before { @skill_level = SkillLevel.new(account_id: 1, name: 'Level 1') }

  subject { @skill_level }

  it { should respond_to :account_id }
  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @skill_level.name = nil }
    it { should_not be_valid }
  end

  describe 'when account_id is not present' do
    before { @skill_level.account_id = nil }
    it { should_not be_valid }
  end
end
