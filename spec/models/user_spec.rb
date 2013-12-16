require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "First", last_name: "Last", email: "user@example.com", suit_size: "M", shirt_size: "M", password: "foobar", password_confirmation: "foobar", account_id: 1) }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:suit_size) }
  it { should respond_to(:shirt_size) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:account_id) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "without account id" do
    before { @user.account_id = nil }
    it { should_not be_valid }
  end

  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end

  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when shirt size is not present" do
    before { @user.shirt_size = " " }
    it { should_not be_valid }
  end

  describe "when suit size is not present" do
    before { @user.suit_size = " " }
    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

    it { should respond_to(:password_confirmation) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when first name is too long" do
    before { @user.first_name = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when last name is too long" do
    before { @user.last_name = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(first_name: "First", last_name: "Last", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  it { should respond_to(:authenticate) }

describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
