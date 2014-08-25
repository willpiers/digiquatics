require 'spec_helper'

describe 'Manage Private Lessons' do

  subject { page }

  describe 'page' do
    let(:account) { FactoryGirl.create(:account) }
    let(:skill_level) do FactoryGirl.create(:skill_level,
                                            account_id: account.id) end
    let(:package) do FactoryGirl.create(:package,
                                        account_id: account.id) end
    let(:user) do
      FactoryGirl.create(:admin,
                         account_id: account.id)
    end

    before do
      login_as(user, scope: :user)

      FactoryGirl.create(:skill_level,
                         name: 'Level 1',
                         account_id: account.id)
      FactoryGirl.create(:skill_level,
                         name: 'Level 2',
                         account_id: account.id)
      visit admin_dashboard_path
    end

    it { should have_link('Add', href: new_position_path) }

    describe 'admin dashboard' do
      it 'should list each package' do
        Package.same_account_as(user).each do |package|
          package.account_id.should eq(user.account_id)
          should have_content(package.name)
          should have_link('Edit', href: edit_package_path(package))
          should have_link('Delete', href: package_path(package))
        end
      end
    end

    describe 'creating a new skill_level' do
      before do
        visit new_skill_level_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new skill_level and redirect to index' do
        expect { click_button 'Submit Skill Level' }
        .to change(SkillLevel, :count).by(1)

        current_path.should == admin_dashboard_path
      end
    end

    describe 'editing an existing skill_level' do
      before do
        visit edit_skill_level_path(skill_level)
        fill_in 'Name', with: 'new skill_level name'
      end

      it 'should update the skill_level and redirect to admin dashboard' do
        expect { click_button 'Update Skill Level' }
        .to_not change(SkillLevel, :count).by(1)

        expect(skill_level.reload.name).to eq('new skill_level name')
        current_path.should == admin_dashboard_path
      end
    end

    describe 'creating a new package' do
      before do
        visit new_package_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new package and redirect to index' do
        expect { click_button 'Submit Package' }
        .to change(Package, :count).by(1)

        current_path.should == admin_dashboard_path
      end
    end

    describe 'editing an existing package' do
      before do
        visit edit_package_path(package)
        fill_in 'Name', with: 'new package name'
      end

      it 'should update the package and redirect to admin dashboard' do
        expect { click_button 'Update Package' }
        .to_not change(Package, :count).by(1)

        expect(package.reload.name).to eq('new package name')
        current_path.should == admin_dashboard_path
      end
    end
  end
end
