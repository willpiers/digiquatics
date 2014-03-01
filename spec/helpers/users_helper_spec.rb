require 'spec_helper'

describe UsersHelper do
  let(:user) { FactoryGirl.create(:user) }

  describe 'full_name helper' do
    it 'should not include the nickname if it doens\'t exist' do
      full_name(user).should == 'Josh Duffy'
    end

    it 'should include the nickname if it exists' do
      user.nickname = 'Wally'

      full_name(user).should == 'Josh (Wally) Duffy'
    end
  end
end
