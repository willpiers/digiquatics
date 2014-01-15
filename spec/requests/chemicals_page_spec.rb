require 'spec_helper'

describe 'Chemicals' do

  subject { page }

  before { visit chemical_records_path }

  describe 'page' do
    it { should have_title(full_title('Chemical Records')) }
    it { should have_selector('h1', text: 'Chemical Records') }
  end
end
