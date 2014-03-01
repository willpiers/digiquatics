require 'spec_helper'

describe 'Chemicals' do
  let!(:account) { FactoryGirl.create(:account) }
  let!(:user) { FactoryGirl.create(:user, account_id: account.id) }

  subject { page }

  before do
    login_as(user, scope: :user)
    visit chemical_records_path
  end

  describe 'page' do
    it { should have_title(full_title('Chemical Records')) }
    it { should have_selector('h1', text: 'Chemical Records') }
  end
end
