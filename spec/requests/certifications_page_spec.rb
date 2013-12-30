require 'spec_helper'

describe 'Certifications' do
  let(:location) { FactoryGirl.create(:location) }
  let(:position) { FactoryGirl.create(:position) }
  let(:user) { FactoryGirl.create(:user, location_id: location.id, position_id: position.id) }

  subject { page }

  describe 'page' do

    it { should have_title(full_title('Certifications')) }
    it { should have_selector('h1', text: 'Certifications') }

      before do
        sign_in user
        FactoryGirl.create(:certification_name, account_id: 1, name: 'CPR/AED1')
        FactoryGirl.create(:certification_name, account_id: 2, name: 'CPR/AED2')
        FactoryGirl.create(:certification, certification_name_id: 1)
        FactoryGirl.create(:certification, certification_name_id: 2)
        visit certifications_path
      end

      it 'should have correct table headers' do
        page.should have_content('First Name')
        page.should have_content('Last Name')
        page.should have_content('Location')
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

    # describe 'sorting' do

    #   describe 'by first name' do

    #     before { click_link 'First Name' }

    #     let(:first_user) { FactoryGirl.create(:user, email: 'hello4@gmail.com', first_name: 'Al') }
    #     let(:next_user) { FactoryGirl.create(:user, email: 'hello5@gmail.com', first_name: 'Bob') }

    #     it { body.index(first_user.first_name).should < body.index(next_user.first_name) }
    #   end

    #   describe 'by last name' do

    #     before { click_link 'Last Name' }

    #     let(:first_user) { FactoryGirl.create(:user, email: 'hello@gmail.com', last_name: 'Al') }
    #     let(:next_user) { FactoryGirl.create(:user, email: 'hello1@gmail.com', last_name: 'Bob') }

    #     it { body.index(first_user.last_name).should < body.index(next_user.last_name) }
    #   end

    #   describe 'by location' do

    #     before { click_link 'Location' }
    #     let(:first_location) { FactoryGirl.create(:location, name: 'Aurora Rec Center') }
    #     let(:next_location) { FactoryGirl.create(:location, name: 'Carmody Rec Center') }

    #     let(:first_user) { FactoryGirl.create(:user, email: 'hello2@gmail.com', location_id: first_location.id) }
    #     let(:next_user) { FactoryGirl.create(:user, email: 'hello3@gmail.com', location_id: next_location.id) }

    #     it { body.index(first_user.location.name).should < body.index(next_user.location.name) }
    #   end
    # end
  end
end
