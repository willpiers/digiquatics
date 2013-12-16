require 'spec_helper'

describe "Private Lessons" do

  	subject { page }

  	describe "page" do

    it { should have_title('Private Lessons') }
    it { should have_selector('h1', text: 'Private Lessons') }
		end
end