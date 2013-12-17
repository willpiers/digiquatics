require 'spec_helper'

describe 'Chemicals' do

  subject { page }

  describe 'page' do
    it { should have_title('Chemicals') }
    it { should have_selector('h1', text: 'Chemicals') }
	end
end
