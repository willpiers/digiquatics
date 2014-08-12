require 'spec_helper'

describe DailyTodo do

  before { @daily_todo = DailyTodo.new(name: 'Item1') }

  subject { @daily_todo }

  it { should respond_to :name }

  it { should be_valid }

  describe 'when name is not present' do
    before { @daily_todo.name = nil }
    it { should_not be_valid }
  end

end
