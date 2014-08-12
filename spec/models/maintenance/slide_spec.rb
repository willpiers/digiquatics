require 'spec_helper'

describe Slide do
  before do
    @slide = Slide.new(location_id: 1, name: 'Big Yellow')
  end

  subject { @slide }

  it { should respond_to(:location_id) }
  it { should respond_to(:name) }

  it { should be_valid }

  describe 'when name is not present' do
    before { @slide.name = ' ' }
    it { should_not be_valid }
  end
end
