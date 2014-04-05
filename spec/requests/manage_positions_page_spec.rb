require 'spec_helper'

describe 'Manage Positions' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:location) { FactoryGirl.create(:location) }
    let(:position) { FactoryGirl.create(:position) }
    let(:user) do
      FactoryGirl.create(:admin,
                         account_id: account.id,
                         location_id: location.id,
                         position_id: position.id)
    end

    before do
      login_as(user, scope: :user)

      FactoryGirl.create(:position,
                         name: 'Advanced Lifeguard',
                         account_id: account.id)
      FactoryGirl.create(:position,
                         name: 'Lifeguard',
                         account_id: account.id)

      position.update_attribute(:account_id, account.id)
      visit admin_dashboard_path
    end

    # it { should have_content('Manage Positions') }
    it { should have_link('New', href: new_position_path) }

    describe 'should list each position' do
      Position.all.each do |position|
        position.account_id.should eq(user.account_id)
        it { should have_content(position.name) }
        it { should have_link('Edit', href: edit_position_path(position)) }
        it { should have_link('Delete', href: position_path(position)) }

      end
    end

    describe 'creating a new position' do
      before do
        visit new_position_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new position and redirect to index' do
        expect { click_button 'Create Position' }
        .to change(Position, :count).by(1)

        current_path.should == admin_dashboard_path
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end
    end

    describe 'editing an existing position' do
      before do
        visit edit_position_path(position)
        fill_in 'Name', with: 'new position name'
      end

      describe 'clicking the back button' do
        before { click_link 'Back' }

        it 'should redirect to admin dash' do
          current_path.should == admin_dashboard_path
        end
      end

      it 'should update the position and redirect to admin dashboard' do
        expect { click_button 'Update Position' }
        .to_not change(Position, :count).by(1)

        expect(position.reload.name).to eq('new position name')
        current_path.should == admin_dashboard_path
      end
    end

    describe 'deleting a position' do
      before do
        visit admin_dashboard_path
      end

      it { should have_link('Delete', href: position_path(position)) }

      it 'should be able to delete position' do
        expect do
          click_link('Delete', match: :first)
        end.to change(Position, :count).by(-1)

        current_path.should == admin_dashboard_path
      end
    end
  end
end
