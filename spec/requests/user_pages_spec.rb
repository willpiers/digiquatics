require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
    before { visit signup_path }

   	it { should have_content(user.first_name) }
    it { should have_title(user.first_name) }
	end

	describe "add account" do
		before { visit signup_path}

	  it { should have_content('Create New User') }
	  it { should have_title('Create New User') }
	end
end
