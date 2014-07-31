require 'spec_helper'

describe UsersHelper do
  let(:user) { FactoryGirl.create(:user) }

  describe 'full_name helper' do
    it 'should include the first name and last name' do
      full_name(user).should == 'Josh Duffy'
    end
  end
end
