require 'spec_helper'

describe 'Manage Account' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) do
    FactoryGirl.create(:user,
                       account_id: account.id,
                       location_id: location.id,
                       position_id: position.id)
  end

  subject { page }

  describe 'page' do
    before do
      login_as(user, scope: :user)
      visit edit_account_path(user.account_id)
    end

    it { should have_selector('legend', text: 'Edit Account') }
  end
end
