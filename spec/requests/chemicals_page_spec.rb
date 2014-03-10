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

  describe 'submit record' do
    before do
      Warden.test_reset!
      login_as(user, scope: :user)
      visit new_chemical_record_path
    end

    describe 'should have the correct title and heading' do
      it { should have_title(full_title('Add Chemical Record')) }
      it { should have_selector('legend', text: 'Add Chemical Record') }
    end

    describe 'with valid information' do
      let(:submit) { 'Submit' }

      before do
        select pool.name, from: 'chemical_record_pool_id'
        select 2,         from: 'chemical_record_free_chlorine_ppm'
        select 3,         from: 'chemical_record_total_chlorine_ppm'
        select 6.8,       from: 'chemical_record_ph'
        select 100,       from: 'chemical_record_alkalinity'
        select 100,       from: 'chemical_record_calcium_hardness'
        fill_in 'chemical_record_pool_temp', with: 89.1
        fill_in 'chemical_record_air_temp', with: 85.6
        select 'Clear',   from: 'chemical_record_water_clarity'
      end

      it 'should create a chemical record' do
        expect { click_button submit }.to change(ChemicalRecord, :count).by(1)
      end
    end
  end
end
