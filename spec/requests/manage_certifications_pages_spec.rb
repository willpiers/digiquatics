require 'spec_helper'

describe "Manage Certifications" do

  subject { page }

  describe "page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:certification_name, name: 'CPR/AED')
      FactoryGirl.create(:certification_name, name: 'Lifeguard')
      visit certification_names_path
    end

    it { should have_title('Manage Certifications') }
    it { should have_selector('h1', text: 'Manage Certifications') }

    it "should list each certification_name" do
      CertificationName.all.each do |cert_name|
        expect(page).to have_content(cert_name.name)
        # Need to add test to check for a delete link for each Certification Name
      end
    end

    describe "links" do
      it { should have_link('Add') }
      it { should have_link('Delete') }
    end
  end

  # describe "profile page" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before { visit signup_path }

  #   it { should have_content("First Name") }
  #   it { should have_title("Create New User") }
  # end

  # describe "add account" do
  #   before { visit signup_path}

  #   it { should have_content('Create New User') }
  #   it { should have_title('Create New User') }
  # end

  # describe "edit" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   before { visit edit_user_path(user) }
  #   before do
  #     sign_in user 
  #     visit edit_user_path(user)
  #   end

  #   describe "page" do
  #     it { should have_content("Update your profile") }
  #     it { should have_title("Edit user") }
  #   end

  #   describe "with invalid information" do
  #     before { click_button "Save changes" }

  #     it { should have_content('error') }
  #   end

  #   describe "with valid information" do
  #     let(:new_first_name)  { "NewFirstName" }
  #     let(:new_email) { "newEmail@example.com" }
    
  #     before do
  #       fill_in "First Name",   with: new_first_name
  #       fill_in "Last Name",    with: "Last"
  #       fill_in "Email",        with: new_email
  #       fill_in "Password",     with: "foobar"
  #       fill_in "Confirm Password", with: "foobar"
  #       select('M', from: 'Suit Size')
  #       select('M', from: 'Shirt Size')
  #       select('M', from: 'Sex')
  #       select('1992', from: "user_date_of_birth_1i")
  #       select('December', from: "user_date_of_birth_2i")
  #       select('15', from: "user_date_of_birth_3i")
  #       select('2013', from: "user_date_of_hire_1i")
  #       select('January', from: "user_date_of_hire_2i")
  #       select('1', from: "user_date_of_hire_3i")
  #       fill_in "Phone Number",   with: "7203879691"
  #       click_button "Save changes"
  #     end

  #     it { should have_title(full_title(new_first_name)) }
  #     it { should have_selector('div.alert.alert-success') }
  #     it { should have_link('Sign out', href: signout_path) }
  #     specify { expect(user.reload.first_name).to eq new_first_name }
  #     specify { expect(user.reload.email).to eq new_email.downcase }
  #   end
  # end

  # describe "signup" do

  #   before { visit signup_path }

  #   let(:submit) { "Create/Save Account" }

  #   describe "with invalid information" do
  #     it "should not create a user" do
  #       expect { click_button submit }.not_to change(User, :count)
  #     end
  #   end

  #   describe "with valid information" do
  #     before do
  #       fill_in "First Name",   with: "First"
  #       fill_in "Last Name",    with: "Last"
  #       fill_in "Email",        with: "user@example.com"
  #       fill_in "Password",     with: "foobar"
  #       fill_in "Confirm Password", with: "foobar"
  #       select('M', :from => 'Suit Size')
  #       select('M', :from => 'Shirt Size')
  #       select('M', :from => 'Sex')
  #       select('1992', from: "user_date_of_birth_1i")
  #       select('December', from: "user_date_of_birth_2i")
  #       select('15', from: "user_date_of_birth_3i")
  #       select('2013', from: "user_date_of_hire_1i")
  #       select('January', from: "user_date_of_hire_2i")
  #       select('1', from: "user_date_of_hire_3i")
  #       fill_in "Phone Number",   with: "7203879691"
  #     end

  #     it "should create a user" do
  #       expect { click_button submit }.to change(User, :count).by(1)
  #     end
      
  #     describe "after saving the user" do
  #       before { click_button submit }
  #       let(:user) { User.find_by(email: 'user@example.com') }

  #       it { should have_link('Sign out') }
  #       it { should have_title(user.first_name) }
  #       it { should have_selector('div.alert.alert-success', text: 'This account has been successfully created!') }
  #     end
  #   end
  # end
end