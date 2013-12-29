require 'spec_helper'

describe "private_lessons/new" do
  before(:each) do
    assign(:private_lesson, stub_model(PrivateLesson,
      :first_name => "MyString",
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new private_lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", private_lessons_path, "post" do
      assert_select "input#private_lesson_first_name[name=?]", "private_lesson[first_name]"
      assert_select "input#private_lesson_email[name=?]", "private_lesson[email]"
    end
  end
end
