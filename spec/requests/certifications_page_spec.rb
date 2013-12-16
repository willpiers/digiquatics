require 'spec_helper'

describe 'Certifications' do

  subject { page }

  describe 'page' do

    it { should have_title(full_title('Certifications')) }
    it { should have_selector('h1', text: 'Certifications') }

    before do
      sign_in FactoryGirl.create(:user, account_id: 1)
      FactoryGirl.create(:certification_name, account_id: 1, name: 'CPR/AED1')
      FactoryGirl.create(:certification_name, account_id: 2, name: 'CPR/AED2')
      FactoryGirl.create(:certification, certification_name_id: 1)
      FactoryGirl.create(:certification, certification_name_id: 2)

      visit certifications_path
    end

    it 'should have table header' do
      page.should have_content('Certification name')
    end

    it 'should list each certification belonging to an account' do
      Certification.joins(:certification_name)
      .where(certification_names: { account_id: 1 }).each do |cert|
        page.should have_content(cert.certification_name.name)
        page.should have_content(cert.user.first_name)
        page.should have_content(cert.expiration_date.strftime('%-m/%-d/%Y'))
      end
    end

    it 'should not list certifications from another account' do
      Certification.joins(:certification_name).where(certification_names: {account_id: 2}).each do |cert|
        page.should_not have_content(cert.certification_name.name)
      end
    end
  end
end
