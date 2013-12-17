require 'spec_helper'

describe 'Attendance' do

  subject { page }

  describe 'page' do
    it { should have_title('Attendance') }
    it { should have_selector('h1', text: 'Attendance') }
	end
end
