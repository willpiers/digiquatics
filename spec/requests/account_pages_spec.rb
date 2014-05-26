require 'spec_helper'

describe 'Account pages' do
  let!(:account) { FactoryGirl.create(:account) }

  subject { page }

  describe 'edit' do
    let!(:user) { FactoryGirl.create(:user, account_id: account.id) }
    before do
      visit edit_account_path(account)
    end

    describe 'should not have user fields' do
      it { should_not have_content('Basic User Information') }
    end
  end
end
