require 'spec_helper'
require 'yaml'

describe FeatureToggle do
  let(:current_user) { double() }
  before do
    current_user.stub(:account_id) { 1 }

    YAML.stub(:load_file)
    .and_return('private_lessons' => true, 'chemicals' => '1,2')
  end

  it 'should return true for features that are toggled on' do
    FeatureToggle.private_lessons?(current_user).should == true
  end

  it 'should return true for features that are toggled on for that account' do
    FeatureToggle.chemicals?(current_user).should == true
  end

  it 'should return nil for features that aren\'t toggled on' do
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

  it 'should still call default methods' do
    FeatureToggle.class.should == Module
  end

  it 'should still call default ? methods' do
    FeatureToggle.kind_of?(Object).should == true
  end
end
