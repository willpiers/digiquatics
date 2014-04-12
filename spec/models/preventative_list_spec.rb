require 'spec_helper'

describe PreventativeList do

  before do @prev_list = PreventativeList.new(name: 'Item1',
                                              task_type: 'Chore')
  end

  subject { @prev_list }

  it { should respond_to :name }
  it { should respond_to :task_type }

  it { should be_valid }

  describe 'when name is not present' do
    before { @prev_list.name = nil }
    it { should_not be_valid }
  end

  describe 'when task type is not present' do
    before { @prev_list.task_type = nil }
    it { should_not be_valid }
  end

end
