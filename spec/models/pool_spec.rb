require 'spec_helper'

describe Pool do

  before { @pool = Pool.new(location_id: "1", name: "Indoor") }

  subject { @pool }

  it { should respond_to(:name) }
  it { should respond_to(:location_id) }

  it { should be_valid }

  describe "when location_id is not present" do
    before { @pool.location_id = nil }
    it { should_not be_valid }
  end

  describe "when pool name is not present" do
    before { @pool.name = " " }
    it { should_not be_valid }
  end
end
