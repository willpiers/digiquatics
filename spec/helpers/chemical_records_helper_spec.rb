require 'spec_helper'

describe ChemicalRecordsHelper do
  describe 'si_calc for status' do
    specify do
      si_calc((-100..-5).step(0.5).to_a.sample, :status)
      .should == 'Severe Corrosion'
    end
  end

  describe 'si_calc for recommendation' do
    specify do
      si_calc((-0.3..0.3).step(0.1).to_a.sample, :recommendation)
      .should == 'No Treatment'
    end
  end

  describe 'si_index_calculator' do
    it 'should calculate the correct si index' do
      si_index_calculator(8, 88, 120, 90).should == 0.27230924567350634
    end
  end
end
