require 'spec_helper'

describe 'Attendance' do

  subject { page }

  before { visit attendance_path }

  describe 'page' do
    it { should have_title(full_title('Attendance')) }
    it { should have_selector('h1', text: 'Attendance') }
	end
end
