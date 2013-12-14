require 'spec_helper'

describe "Manage Account" do

  subject { page }

  describe "page" do

    let(:account) { FactoryGirl.create(:account) }
    let(:user) { FactoryGirl.create(:user) }
    before { user = account.users.build(user) }
    before do
      sign_in user 
      visit edit_account_path(user)
    end

    it { should have_title('Manage Account') }
    it { should have_selector('h1', text: 'Manage Account') }
  end
end