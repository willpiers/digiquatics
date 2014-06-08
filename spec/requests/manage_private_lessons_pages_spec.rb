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

    it { should have_link('New', href: new_position_path) }

    describe 'admin dashboard' do
      it { should have_content('Skill Levels') }

      it 'should list each skill_level' do
        SkillLevel.same_account_as(user).each do |skill_level|
          skill_level.account_id.should eq(user.account_id)
          should have_content(skill_level.name)
          should have_link('Edit', href: edit_skill_level_path(skill_level))
          should have_link('Delete', href: skill_level_path(skill_level))
        end
      end

      it { should have_content('Packages') }

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
        expect { click_button 'Create Skill level' }
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
        expect { click_button 'Update Skill level' }
        .to_not change(SkillLevel, :count).by(1)

        expect(skill_level.reload.name).to eq('new skill_level name')
        current_path.should == admin_dashboard_path
      end
    end

    describe 'deleting a skill_level' do
      before do
        visit admin_dashboard_path
      end

      it 'should be able to delete skill_level' do
        expect do
          click_link('Delete', match: :first)
        end.to change(SkillLevel, :count).by(-1)

        current_path.should == admin_dashboard_path
      end
    end

    describe 'creating a new package' do
      before do
        visit new_package_path
        fill_in 'Name', with: 'Ridge Rec Center'
      end

      it 'should create a new package and redirect to index' do
        expect { click_button 'Create Package' }
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

    # CANNOT TEST FOR DELETE LINK FOR PACKAGE BECAUSE THERE
    # ARE MANY DELETE LINKS ON THIS PAGE

    # describe 'deleting a package' do
    #   before do
    #     visit admin_dashboard_path
    #   end

    #   it 'should be able to delete package' do
    #     expect do
    #       click_link('Delete', match: :first)
    #     end.to change(Package, :count).by(-1)

    #     current_path.should == admin_dashboard_path
    #   end
    # end
  end
end
