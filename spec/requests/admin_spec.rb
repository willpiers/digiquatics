require 'spec_helper'

describe "admin setup" do
  subject { page }

  let(:admin) { FactoryGirl.create(:user) }
  before { sign_in admin }

  describe "manage" do
    describe "users" do
      before { click_link('Manage Users') }

      it { should have_title(full_title('All users')) }
    end

    describe "locations" do
      before { click_link('Manage Locations') }

      it { should have_title(full_title('Manage Locations')) }
    end

    describe "positions" do
      before { click_link('Manage Positions') }

      it { should have_title(full_title('Manage Positions')) }
    end

    describe "chemicals" do
      before { click_link('Manage Chemicals') }

      it { should have_title(full_title('Manage Chemicals')) }
    end

    describe "certifications" do
      before { click_link('Manage Certifications') }

      it { should have_title(full_title('Manage Certifications')) }
    end

    describe "lessons" do
    end

    describe "billing" do
    end
  end
end