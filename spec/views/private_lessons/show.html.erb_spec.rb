require 'spec_helper'

describe "private_lessons/show" do
  before(:each) do
    @private_lesson = assign(:private_lesson, stub_model(PrivateLesson,
      :first_name => "First Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Email/)
  end
end
