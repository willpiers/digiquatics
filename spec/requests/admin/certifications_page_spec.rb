require 'spec_helper'

describe 'Certifications' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location, account_id: account.id) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) do
    FactoryGirl.create(:user,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  let!(:admin) do
    FactoryGirl.create(:admin,
                       location_id: location.id,
                       position_id: position.id,
                       account_id: account.id)
  end

  subject { page }

  describe 'page' do
    let!(:new_cert_name) do
      FactoryGirl.create(:certification_name, name: 'new')
    end

    let!(:old_cert_name) do
      FactoryGirl.create(:certification_name, name: 'old')
    end

    it { should have_title(full_title('Certifications')) }
    it { should have_selector('h1', text: 'Certifications') }

    before do
      login_as(user, scope: :user)
      FactoryGirl.create(:certification_name, account_id: 1, name: 'CPR/AED1')
      FactoryGirl.create(:certification_name, account_id: 2, name: 'CPR/AED2')
      FactoryGirl.create(:certification,
                         certification_name_id: 1,
                         user_id: user.id)
      FactoryGirl.create(:certification,
                         certification_name_id: 2,
                         user_id: user.id)
      visit certifications_path
    end

    it 'should have correct table headers' do
      page.should have_content('First Name')
      page.should have_content('Last Name')
      page.should have_content('Location')
    end

    let(:cert_user) { User.find_by_id(user.id) }

    it 'should have certification dates in the correct order' do
      cert_user.certifications.first.certification_name_id.should eq(1)
      cert_user.certifications.second.certification_name_id.should eq(2)
    end

    it 'should list each certification belonging to an account' do
      Certification.joins(:certification_name)
      .where(certification_names: { account_id: 1 }).each do |cert|
        page.should have_content('userData.lastName')
        page.should have_content('userData.firstName')
        page.should have_content('userData[certName.name] | formatDate')
      end
    end
  end

  describe 'on user edit page' do
    let!(:old_cert_name) do
      FactoryGirl.create(:certification_name,
                         account_id: account.id,
                         name: 'old')
    end

    let!(:new_cert_name) do
      FactoryGirl.create(:certification_name,
                         account_id: account.id,
                         name: 'new_cert_name')
    end

    before do
      Warden.test_reset!
      login_as(admin, scope: :user)
      FactoryGirl.create(:certification,
                         certification_name_id: old_cert_name.id,
                         user_id: user.id)

      visit edit_user_path(user)
      select new_cert_name.name,
             from: 'user_certifications_attributes_0_certification_name_id'
      click_button 'Save Changes'
    end

    it { should have_content('new_cert_name') }
  end

  describe 'user edit page' do
    let!(:new_cert_name) do
      FactoryGirl.create(:certification_name,
                         account_id: account.id,
                         name: 'new_cert_name')
    end
    before do
      Warden.test_reset!
      login_as(admin, scope: :user)
      FactoryGirl.create(:certification,
                         certification_name_id: new_cert_name.id,
                         user_id: user.id)
      visit edit_user_path(user)
    end

    describe 'should be able to set cert year three years out' do
      it { should have_content('2017') }
    end
  end
end
