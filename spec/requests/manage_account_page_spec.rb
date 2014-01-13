require 'spec_helper'

describe 'Manage Account' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, account_id: account.id, 
    location_id: location.id, position_id: position.id) }

  subject { page }

  describe 'page' do

    before { user = account.users.build(user) }
    before do
      sign_in user
      visit edit_account_path(user.account_id)
    end

    it { should have_title('Manage Account') }
    it { should have_selector('h1', text: 'Manage Account') }
  end
end