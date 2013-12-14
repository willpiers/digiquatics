require 'spec_helper'

describe "Certifications" do
  before { visit certifications_path }

  subject { page }

  describe "page" do

    # let(:account) { FactoryGirl.create(:account) }
    # let(:user) { FactoryGirl.create(:user) }
    # before { user = account.users.build(user) }
    # before do
    #   sign_in user 
    #   visit edit_account_path(user)
    # end

    it { should have_title('Certifications') }
    it { should have_selector('h1', text: 'Certifications') }
  end
end