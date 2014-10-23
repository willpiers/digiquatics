require 'spec_helper'
require 'yaml'

describe FeatureToggle do
  let(:current_user) { double() }
  before do
    FeatureToggle.unstub :show_feature?

    current_user.stub(:account_id) { 1 }

    File.stub(:exist?).and_return true

    YAML.stub(:load_file)
    .and_return('private_lessons' => true, 'chemicals' => '1,2')
  end

  after { FeatureToggle.stub(:show_feature?).and_return true }

  it 'returns true for features that are toggled on' do
    FeatureToggle.private_lessons?(current_user).should == true
  end

  it 'returns true for features that are toggled on for that account' do
    FeatureToggle.chemicals?(current_user).should == true
  end

  it 'returns nil for features that aren\'t toggled on' do
    FeatureToggle.scheduling?(current_user).should == false
  end

  it 'checks only boolean if no current_user is passed in' do
    FeatureToggle.private_lessons?.should == true
  end

  it 'checks only boolean if no current_user is passed in' do
    FeatureToggle.maintenance?.should == false
  end

  it 'defaults to false if no current_user is passed in for account toggles' do
    FeatureToggle.chemicals?.should == false
  end

  context 'without file' do
    before do
      File.stub(:exist?).and_return false
    end

    it 'returns false for everything' do
      FeatureToggle.scheduling?.should == false
      FeatureToggle.chemicals?.should == false
      FeatureToggle.maintenance?(current_user).should == false
    end
  end
end
