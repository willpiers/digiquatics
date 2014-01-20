require 'spec_helper'

describe 'Manage Certifications' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) { FactoryGirl.create(:location) }
    let(:position) { FactoryGirl.create(:position) }
    let(:user) { FactoryGirl.create(:admin,
                                    account_id: account.id,
                                    location_id: location.id,
                                    position_id: position.id) }
    let!(:cert_name1) { FactoryGirl.create(:certification_name,
                                           name: 'CPR/AED',
                                           account_id: account.id) }
    let!(:cert_name2) { FactoryGirl.create(:certification_name,
                                           name: 'Lifeguard',
                                           account_id: account.id) }

    before do
      sign_in user
      visit admin_dashboard_path
    end

    it { should have_content('Manage Certifications') }
    it { should have_link('New', href: new_certification_name_path) }

    describe 'should list each certification_name' do
      CertificationName.all.each do |cert_name|
        cert_name.account_id.should eq(user.account_id)
        it { should have_content(cert_name.name) }
        it { should have_link('Edit',
          href: edit_certification_name_path(certification_name))}
        it { should have_link('Delete',
          href: certification_name_path(certification_name)) }
      end
    end

    describe 'creating a new certification_name' do
      before do
        visit new_certification_name_path
        fill_in 'Name', with: 'LG'
      end

      it 'should create a new cert name and redirect to admin dashboard' do
        expect { click_button 'Create Certification name'}
        .to change(CertificationName, :count).by(1)

        current_path.should == admin_dashboard_path
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end
    end

    describe 'editing an existing certification_name' do
      before do
        visit edit_certification_name_path(cert_name1)
        fill_in 'Name', with: 'new certification_name name'
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end

      it 'should update the cert_name and redirect to admin dashboard' do
        expect { click_button 'Update Certification name'}
        .to_not change(CertificationName, :count).by(1)

        expect(cert_name1.reload.name).to eq('new certification_name name')
        current_path.should == admin_dashboard_path
      end
    end

    describe 'deleting a certification_name' do
      before do
        visit admin_dashboard_path
      end

      it 'should delete certification_name' do
        expect do
          click_link('Delete', match: :first)
        end.to change(CertificationName, :count).by(-1)

        current_path.should == admin_dashboard_path
      end
    end
  end
end
