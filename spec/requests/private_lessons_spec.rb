require 'spec_helper'

describe "PrivateLessons" do
  describe "GET /private_lessons" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get private_lessons_path
      response.status.should be(200)
    end
  end
end
