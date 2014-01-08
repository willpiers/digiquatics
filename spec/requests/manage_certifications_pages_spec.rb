require 'spec_helper'

describe 'Manage Certifications' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) { FactoryGirl.create(:location) }
    let(:position) { FactoryGirl.create(:position) }
    let(:user) { FactoryGirl.create(:user, account_id: account.id, 
      location_id: location.id, position_id: position.id) }

    before do
      sign_in user
      FactoryGirl.create(:certification_name, name: 'CPR/AED', 
        account_id: account.id)
      FactoryGirl.create(:certification_name, name: 'Lifeguard', 
        account_id: account.id)
      visit certification_names_path
    end

    it { should have_title('Manage Certifications') }
    it { should have_selector('h1', text: 'Manage Certifications') }

    it 'should list each certification_name' do
      CertificationName.all.each do |cert_name|
        cert_name.account_id.should eq(user.account_id)
        expect(page).to have_content(cert_name.name)
        # Need to add test to check for a delete link for each Certification Name
      end
    end

    describe 'links' do
      it { should have_link('Add') }
      it { should have_link('Delete') }
    end
  end
end
