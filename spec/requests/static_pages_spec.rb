require 'spec_helper'

describe 'Static pages' do
  describe 'Landing page' do
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

  describe 'Instructions page' do
    let!(:account) { FactoryGirl.create(:account) }
    let(:user) do
      FactoryGirl.create(:admin,
                         account_id: account.id)
    end

    # before do
    #   login_as(user, scope: :user)
    # end
  end
end
