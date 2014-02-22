require 'spec_helper'

describe 'Static pages' do
  describe 'Home page' do
    before { visit '/' }

    it 'should have the content \'DigiQuatics\'' do
      expect(page).to have_content('DigiQuatics')
    end

    it 'should have the base title' do
      expect(page).to have_title('DigiQuatics')
    end

    it 'should not have a custom page title' do
      expect(page).not_to have_title('| Home')
    end
  end
end
