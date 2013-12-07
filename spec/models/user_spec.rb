require 'spec_helper'

describe User do

  before { @user = User.new(first_name: "First", last_name: "Last", email: "user@example.com", suit_size: "M", shirt_size: "M") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:suit_size) }
  it { should respond_to(:shirt_size) }

  it { should be_valid }

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

  describe "when first name is too long" do
    before { @user.first_name = "a" * 16 }
    it { should_not be_valid }
  end

  describe "when last name is too long" do
    before { @user.last_name = "a" * 16 }
    it { should_not be_valid }
  end
end