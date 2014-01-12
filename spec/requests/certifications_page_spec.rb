require 'spec_helper'

# Rspec::Matchers.define :appear_before do |later_content|
#   match do |earlier_content|
#     page.body.index(earlier_content) < page.body.index(later_content)
#   end
# end

describe 'Certifications' do
  let(:account) { FactoryGirl.create(:account) }
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, location_id: location.id,
    position_id: position.id, account_id: account.id) }

  subject { page }

  describe 'page' do

    let!(:new_cert_name) { FactoryGirl.create(:certification_name, name: 'new') }
    let!(:old_cert_name) { FactoryGirl.create(:certification_name, name: 'old') }

    it { should have_title(full_title('Certifications')) }
    it { should have_selector('h1', text: 'Certifications') }

      before do
        sign_in user
        FactoryGirl.create(:certification_name, account_id: 1, name: 'CPR/AED1')
        FactoryGirl.create(:certification_name, account_id: 2, name: 'CPR/AED2')
        FactoryGirl.create(:certification, certification_name_id: 1, user_id: user.id)
        FactoryGirl.create(:certification, certification_name_id: 2, user_id: user.id)
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
          page.should have_content(cert.certification_name.name)
          page.should have_content(cert.user.first_name)
          page.should have_content(cert.expiration_date.strftime('%-m/%-d/%Y'))
        end
      end

      it 'should not list certifications from another account' do
        Certification.joins(:certification_name)
          .where(certification_names: {account_id: 2}).each do |cert|
          page.should_not have_content(cert.certification_name.name)
      end
    end
  end
end
