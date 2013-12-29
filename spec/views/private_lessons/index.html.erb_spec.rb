require 'spec_helper'

describe "private_lessons/index" do
  before(:each) do
    assign(:private_lessons, [
      stub_model(PrivateLesson,
        :first_name => "First Name",
        :email => "Email"
      ),
      stub_model(PrivateLesson,
        :first_name => "First Name",
        :email => "Email"
      )
    ])
  end

  it "renders a list of private_lessons" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
