require 'spec_helper'

describe 'Manage Positions' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) { FactoryGirl.create(:location) }
    let(:position) { FactoryGirl.create(:position) }
    let(:user) { FactoryGirl.create(:user, account_id: account.id,
      location_id: location.id, position_id: position.id) }

    before do
      sign_in user
      FactoryGirl.create(:position, name: 'Carmody Rec Center',
        account_id: account.id)
      FactoryGirl.create(:position, name: 'Green Mtn Rec Center',
        account_id: account.id)
      position.update_attribute(:account_id, account.id)
      visit positions_path
    end

    it { should have_title('Manage Positions') }
    it { should have_selector('h1', text: 'Manage Positions') }

    it 'should list each position' do
      Position.all.each do |position|
        position.account_id.should eq(user.account_id)
        page.should have_content(position.name)
      end
    end

    describe 'links' do
      it { should have_link('New Position') }
      it { should have_link('Edit') }
      it { should have_link('Delete') }
    end

    describe 'creating a new position' do
      before do
        visit new_position_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new position' do
        expect { click_button 'Create Position'}
        .to change(Position, :count).by(1)
      end
    end
  end
end
