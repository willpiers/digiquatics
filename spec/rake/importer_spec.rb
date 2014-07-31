require 'spec_helper'
require Rails.root.join('lib/modules/importer')

describe Importer do
  describe 'import' do
    before(:all) do
      User.destroy_all
      Location.destroy_all
      Position.destroy_all
      CertificationName.destroy_all
      Account.destroy_all
      user_data_file = Rails.root.join('db/data/example_user_import.csv')
      cert_data_file =
        Rails.root.join('db/data/example_certification_import.csv')

      Importer.import(user_data_file: user_data_file,
                      cert_data_file: cert_data_file)
    end

    describe 'for the account' do
      it 'should have created one account' do
        Account.count.should == 1
      end

      it 'should have the right name' do
        Account.last.name.should == 'DigiQuatics'
      end
    end

    describe 'for users' do
      let(:user) { User.first }

      it 'should have created the right number of users' do
        User.count.should == 2
      end

      it 'should have the right required info' do
        user.first_name.should == 'Foo'
        user.last_name.should == 'Bar'
        user.email.should == 'foo@bar.quz'
      end

      it 'should have all other available info' do
        user.phone_number.should == '1234567890'
        user.secondary_phone_number.should == '123-456-7890'
        user.date_of_birth.should == Date.parse('Sun, 12 Sep 1993')
        user.date_of_hire.should == Date.parse('Mon, 13 Sep 1993')
        user.active.should be_false
      end

      it 'should have the correct associations' do
      end
    end

    describe 'for positions' do
      it 'should have created the right number of positions' do
        Position.count.should == 1
      end

      it 'should have the right name' do
        Position.last.name.should == 'Lifeguard'
      end
    end

    describe 'for locations' do
      it 'should have created the right number of locations' do
        Location.count.should == 1
      end

      it 'should have the right name' do
        Location.last.name.should == 'La Alma'
      end
    end

    describe 'for certifications' do
      it 'should have created the right number of certification names' do
        CertificationName.count.should == 2
      end

      it 'should have the right name' do
        CertificationName.last.name.should == 'WSI'
      end

      it 'should have created the right number of certifications' do
        Certification.all.count.should == 4
      end
    end
  end
end
