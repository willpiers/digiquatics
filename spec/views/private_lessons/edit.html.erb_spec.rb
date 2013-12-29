require 'spec_helper'

describe "private_lessons/edit" do
  before(:each) do
    @private_lesson = assign(:private_lesson, stub_model(PrivateLesson,
      :first_name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit private_lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", private_lesson_path(@private_lesson), "post" do
      assert_select "input#private_lesson_first_name[name=?]", "private_lesson[first_name]"
      assert_select "input#private_lesson_email[name=?]", "private_lesson[email]"
    end
  end
end
