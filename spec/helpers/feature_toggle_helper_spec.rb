require 'spec_helper'

describe FeatureToggleHelper do
  before do
    FeatureToggleHelper.stub(:load_feature_toggles)
    .and_return('private_lessons' => true)
  end

  it 'should return true for features that are toggled on' do
    FeatureToggleHelper.private_lessons?.should == true
  end

  it 'should return nil for features that aren\'t toggled on' do
    FeatureToggleHelper.scheduling?.should be_nil
  end

  it 'should still call default methods' do
    FeatureToggleHelper.class.should == Module
  end

  it 'should still call default ? methods' do
    FeatureToggleHelper.kind_of?(Object).should == true
  end
end
