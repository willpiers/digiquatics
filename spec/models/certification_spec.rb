require 'spec_helper'

describe Certification do

  before { @certfication = Certification.new(user_id: 1, 
    certification_name_id: 1, expiration_date: '2012-02-03') }
  subject { @certfication }

  it { should respond_to(:user_id) }
  it { should respond_to(:certification_name_id) }
  it { should respond_to(:expiration_date) }

  describe "when expiration_date is not present" do
    before { @certfication.expiration_date = nil }
    it { should_not be_valid }
  end

  describe "when user id is not present" do
    before { @certfication.user_id = nil }
    it { should_not be_valid }
  end

  describe "when certification name id is not present" do
    before { @certfication.certification_name_id = nil }
    it { should_not be_valid }
  end
end