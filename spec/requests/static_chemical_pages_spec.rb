require 'spec_helper'

describe 'Chemical Statistics' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:position) { FactoryGirl.create(:position, account_id: account.id) }

  let!(:admin) do
    FactoryGirl.create(:admin,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  subject { page }

  describe 'page' do
    before do
      login_as(admin, scope: :user)
      visit chemical_record_stats_path
    end

    it { should have_selector('h1', text: 'Chemical Statistics') }
  end
end
