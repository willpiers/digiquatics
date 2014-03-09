require 'spec_helper'

describe 'Chemicals' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user, account_id: account.id) }

  subject { page }

  before do
    login_as(user, scope: :user)
    visit chemical_records_path
  end

  describe 'page' do

    describe 'should have the correct title and heading' do
      it { should have_title(full_title('Chemical Records')) }
      it { should have_selector('h1', text: 'Chemical Records') }
    end

    describe 'should have correct headers' do
      it { should have_content('Location') }
      it { should have_content('Pool') }
      it { should have_content('Free Cl') }
      it { should have_content('Combined Cl') }
      it { should have_content('Total Cl') }
      it { should have_content('PH') }
      it { should have_content('Alk') }
      it { should have_content('CH') }
      it { should have_content('Pool(F)') }
      it { should have_content('Air(F)') }
      it { should have_content('SI Index') }
      it { should have_content('SI Status') }
      it { should have_content('Water Clarity') }
      it { should have_content('Time') }
    end
  end
end
