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

describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before dof
        fill_in "First Name",   with: "First"
        fill_in "Last Name",    with: "Last"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
        fill_in "Suit Size",   with: "M"
        fill_in "Shirt Size",   with: "M"
        fill_in "Sex",   with: "M"
        fill_in "Date of Birth",   with: "2000-01-30"
        fill_in "Date of Hire",   with: "2013-09-13"
        fill_in "Phone Number",   with: "7203879691"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end