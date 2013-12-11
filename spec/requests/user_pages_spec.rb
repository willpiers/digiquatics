require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, first_name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, first_name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.first_name)
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit signup_path }

    it { should have_content("First Name") }
    it { should have_title("Create New User") }
  end

  describe "add account" do
    before { visit signup_path}

    it { should have_content('Create New User') }
    it { should have_title('Create New User') }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
    before do
      sign_in user 
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_first_name)  { "First" }
      let(:new_email) { "new@example.com" }
    
      before do
        fill_in "First Name",   with: new_first_name
        fill_in "Last Name",    with: "Last"
        fill_in "Email",        with: new_email
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
        select('M', :from => 'Suit Size')
        select('M', :from => 'Shirt Size')
        select('M', :from => 'Sex')
        fill_in "Date of Birth",   with: "2000-01-30"
        fill_in "Date of Hire",   with: "2013-09-13"
        fill_in "Phone Number",   with: "7203879691"
      end

      it { should have_title(new_first_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_first_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create/Save Account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First Name",   with: "First"
        fill_in "Last Name",    with: "Last"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm Password", with: "foobar"
        select('M', :from => 'Suit Size')
        select('M', :from => 'Shirt Size')
        select('M', :from => 'Sex')
        fill_in "Date of Birth",   with: "2000-01-30"
        fill_in "Date of Hire",   with: "2013-09-13"
        fill_in "Phone Number",   with: "7203879691"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.first_name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
end