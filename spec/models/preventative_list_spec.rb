require 'spec_helper'

describe PreventativeList do

  before { @prev_list = PreventativeList.new(name: 'Item1') }

  subject { @prev_list }

  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @prev_list.name = nil }
    it { should_not be_valid }
  end

end
