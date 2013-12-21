require 'spec_helper'

describe 'Chemicals' do

  subject { page }

  before { visit chemicals_path }

  describe 'page' do
    it { should have_title(full_title('Chemicals')) }
    it { should have_selector('h1', text: 'Chemicals') }
	end
end
