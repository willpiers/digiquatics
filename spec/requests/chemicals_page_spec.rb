require 'spec_helper'

describe 'Chemicals' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let!(:pool) { FactoryGirl.create(:pool, location_id: location.id) }
  let!(:user) do
    FactoryGirl.create(:user, account_id: account.id, location_id: location.id)
  end

  subject { page }

  describe 'index' do
    before do
      login_as(user, scope: :user)
      visit chemical_records_path
    end

    describe 'should have the correct title and heading' do
      it { should have_title(full_title('Chemical Records')) }
      it { should have_selector('h1', text: 'Chemical Records') }
    end

    describe 'should have correct headers' do
      it { should have_content('Free Cl') }
      it { should have_content('Total Cl') }
      it { should have_content('PH') }
      it { should have_content('Alk') }
      it { should have_content('CH') }
      it { should have_content('Pool(F)') }
      it { should have_content('Air(F)') }
      it { should have_content('SI Index') }
      it { should have_content('Water Clarity') }
      it { should have_content('Time') }
    end
  end

  describe 'stats' do
    before do
      login_as(user, scope: :user)
      visit chemical_record_stats_path
    end

    describe 'should have the correct title and heading' do
      it { should have_title(full_title('Chemical Record Analytics')) }
      it { should have_selector('h1', text: 'Chemical Record Analytics') }
    end
  end
end
