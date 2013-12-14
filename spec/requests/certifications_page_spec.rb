require 'spec_helper'

describe "Certifications" do
  before { visit certifications_path }

  subject { page }

  describe "page" do

    it { should have_title('Certifications') }
    it { should have_selector('h1', text: 'Certifications') }

    let(:account) { FactoryGirl.create(:account, id: "1", name: "City of Lakewood") }
    let(:lakewood_user) { FactoryGirl.create(:user, account_id: account.id) }
    let(:certification_name) { FactoryGirl.create(:certification_name, account_id: "1", name: "CPR/AED") }

    before do
      # let(:other_account) { FactoryGirl.create(:account, id: "2", name: "Foothills" ) }
      # let(:lakewood_cert) { FactoryGirl.create(:certification, certification_name_id: certification_name.id) }
      # let(:foothills_cert) { FactoryGirl.create(:certification, certification_name_id: certification_name.id) }
      # let(:foothills_user) { FactoryGirl.create(:user, account_id: other_account.id) }
      sign_in lakewood_user
      FactoryGirl.create(:certification_name, account_id: "1", name: "CPR/AED1")
      FactoryGirl.create(:certification_name, account_id: "2", name: "CPR/AED2")
      FactoryGirl.create(:certification, certification_name_id: "1")
      FactoryGirl.create(:certification, certification_name_id: "2")

      # let(:foothills_cert) { FactoryGirl.create(:certification, certification_name_id: certification_name.id) }
      # let(:lakewood_user) { FactoryGirl.create(:user, account_id: account.id) }
      # let(:foothills_user) { FactoryGirl.create(:user, account_id: other_account.id) }
      visit certifications_path
    end

    it "should have table header" do
      expect(page).to have_content("Certification name")
    end

    it "should list each certification belonging to an account" do
      Certification.all.where(account_id = "1").each do |cert|
        expect(page).to have_content(cert.certification_name.name)
        expect(page).to have_content(cert.user.first_name)
        expect(page).to have_content(cert.expiration_date.strftime('%-m/%-d/%Y') )
      end
    end

    it "should not list certifications from another account" do
      Certification.all.where(account_id = "2").each do |cert|
        expect(page).to_not have_content(cert.certification_name.name)
        expect(page).to_not have_content(cert.user.first_name)
        expect(page).to_not have_content(cert.expiration_date.strftime('%-m/%-d/%Y') )
      end
    end
  end
end